# frozen_string_literal: true

# This controller is main controller of application
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from CanCan::AccessDenied do |exception|
    if current_user.has_role? :admin
      redirect_to admin_users_url, notice: exception.message
    elsif current_user.has_role? :employee
      redirect_to employee_user_url, notice: exception.message
    else
      redirect_to root_url, notice: exception.message
    end
  end

  def after_sign_in_path_for(_resource)
    if resource.has_role?(:admin)
      admin_users_path
    elsif resource.has_role?(:superadmin)
      superadmin_users_path
    elsif resource.has_role?(:employee)
      employee_user_path(@user)
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
