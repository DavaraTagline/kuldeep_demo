class Api::V1::ApiRegistrationsController < Devise::RegistrationsController
  respond_to :json
  skip_before_action :verify_authenticity_token
  def create
    @user = User.new(sign_up_params)

    if @user.save
      token = @user.generate_jwt
      render json: { message: 'Sign up done!!!!', token: token }
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :phone, :gender, :state_id, :city_id, :password)
  end
end
