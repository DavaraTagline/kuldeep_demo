class Api::V1::BaseController < ApplicationController
  respond_to :json
  def success_json(data, msg)
    render json: { status: 'Success', message: msg, data: data, status_code: 200, errors: [] }
  end

  def err_json(err, msg, code)
    render json: { status: 'Error', message: msg, data: [], status_code: code, errors: err }
  end

  private

  def process_token
    if request.headers['Authorization'].present?
      puts "------------#{request.headers['Authorization'].inspect}"
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
