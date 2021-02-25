class Api::V1::ApiSessionsController < Devise::SessionsController
  respond_to :json
  skip_before_action :verify_authenticity_token
  before_action :process_token, only: [:destroy]
  skip_before_action :verify_signed_out_user
  before_action :current_user, only: [:destroy]
  def create
    user = User.find_by(email: sign_in_params[:email])

    if user && user.valid_password?(sign_in_params[:password])
      sign_in(user)
      auth_token = user.generate_jwt
      render json: { message: 'Logged in!!!!', token: auth_token }
    else
      render json: { error: 'email or password may be wrong!' }
    end
  end

  def destroy
    sign_out(current_user)
    render json: { message: 'logout successfully!' }
  end

  private

  def sign_in_params
    params.permit(:email, :password, :format, :api_session)
  end

  def process_token
    if request.headers['Authorization'].present?
      begin
        jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1],
                                 Rails.application.secrets.secret_key_base).first
        @current_user_id = jwt_payload['id']
      rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
        head :unauthorized
      end
    else
      render json: { error: 'You are not authorized!!!!!' }
    end
  end

  def authenticate_user!(_options = {})
    head :unauthorized unless signed_in?
  end

  def current_user
    @current_user || User.find(@current_user_id)
  end

  def signed_in?
    @current_user_id.present?
  end
end
