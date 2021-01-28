# frozen_string_literal: true

# This controller is main controller of application
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(_resource)
    userdetails_index_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email phone gender state_id city_id password])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[name email phone gender state_id city_id password current_password])
  end
end
