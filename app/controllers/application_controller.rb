class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    def after_sign_in_path_for(resource)
      userdetails_index_path
    end
    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:email,:phone,:gender,:state,:city,:password])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :phone, :gender, :state, :city, :password, :current_password])
    end
end
