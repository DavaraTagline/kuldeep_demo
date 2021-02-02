# frozen_string_literal: true

# This controller is main controller of application
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to user_index_url, notice: exception.message
  end

  def after_sign_in_path_for(_resource)
    if resource.has_role?(:admin)
      admin_users_path
    elsif resource.has_role?(:superadmin)
      superadmin_users_path
    elsif resource.has_role?(:employee)
      employee_users_path
    else
      root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email phone gender state_id city_id password])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[name email phone gender state_id city_id password current_password])
  end
end
