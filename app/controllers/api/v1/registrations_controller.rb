class Api::V1::RegistrationsController < Devise::RegistrationsController#Api::V1::BaseController
  respond_to :json
  skip_before_action :verify_authenticity_token
  def create
    build_resource(sign_up_params)
    resource.save
    sign_up(resource_name, resource) if resource.persisted?
    render json: resource
  end
  # def create
  #   super { |resource| @resource = resource }
  # end
 
  #   def create
  #     @user = User.new(sign_up_params)
     
  #     if @user.save
  #       #token = @user.generate_jwt
  #       render json: @user #token.to_json
  #     else
  #       render json: { errors:  @user.errors  }, status: :unprocessable_entity
  #     end
  #   end

    private
    def sign_up_params
      params.require(:user).permit(:name, :email, :phone, :gender, :state_id, :city_id, :password)
    end
end