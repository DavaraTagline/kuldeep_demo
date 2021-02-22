class Api::V1::BaseController < ApplicationController
    protect_from_forgery with: :null_session
    respond_to :json
    #before_action :process_token
    def success_json(data, msg)
        return render json: {status: 'Success', message: msg, data: data, status_code: 200, errors: []}
      end
    
    def err_json(err, msg, code)
        return render json: {status: 'Error', message: msg, data: [], status_code: code, errors: err}
    end

    private

    # def process_token
    #     if request.headers['Authorization'].present?
    #         begin
    #         jwt_payload = JWT.decode(request.headers['Authorization'], Rails.application.secrets.secret_key_base).first
    #         @current_user_id = jwt_payload['id']
    #         rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
    #         head :unauthorized
    #         end
    #     end
    # end

    # def authenticate_user!(options = {})
    #     head :unauthorized unless signed_in?
    # end

    # def current_user
    #     @current_user || User.find(@current_user_id)
    # end

    # def signed_in?
    #     @current_user_id.present?
    # end

end