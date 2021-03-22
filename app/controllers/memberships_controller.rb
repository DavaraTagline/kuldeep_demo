class MembershipsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :paypal_init, except: :new

    def create_order
        price = params[:price]
        request = PayPalCheckoutSdk::Orders::OrdersCreateRequest::new
        request.request_body({
            :intent => 'CAPTURE',
            :purchase_units => [
            {
                :amount => {
                :currency_code => 'USD',
                :value => price
                }
            }
            ]
        })
        begin
            response = @client.execute request
            membership = Membership.new
            membership.price = price.to_i
            membership.token = response.result.id
            membership.user_id = current_user.id

            if membership.save
                return render :json => {:token => response.result.id}, :status => :ok
            end
        rescue PayPalHttp::HttpError => ioe
            # HANDLE THE ERROR
        end
    end

    def capture_order
        request = PayPalCheckoutSdk::Orders::OrdersCaptureRequest::new params[:order_id]
        begin
            response = @client.execute request
            membership = Membership.find_by :token => params[:order_id]
            membership.paid = response.result.status == 'COMPLETED'
            if membership.save
            return render :json => {:status => response.result.status}, :status => :ok
            end
        rescue PayPalHttp::HttpError => ioe
            # HANDLE THE ERROR
        end
    end

    def new
    end

    private

    def paypal_init
        client_id = Rails.application.credentials.paypal[:client_id]
        client_secret = Rails.application.credentials.paypal[:client_secret]

        environment = PayPal::SandboxEnvironment.new client_id, client_secret
        @client = PayPal::PayPalHttpClient.new environment
    end
end
