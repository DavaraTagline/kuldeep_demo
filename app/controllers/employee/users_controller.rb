# frozen_string_literal: true

# This conntroller used to display userdetails
module Employee
  # This controller is for EmployeeUser
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :restrict_user
    before_action :set_employee_user, only: %i[show]
    load_and_authorize_resource

    def show
    end

    private

    def restrict_user
      unless current_user.has_role? :employee
        if current_user.has_role? :superadmin
          redirect_to superadmin_users_path, notice: 'You are not allowed!'
        elsif current_user.has_role? :admin
          redirect_to admin_users_path, notice: 'You are not allowed!'
        else
          redirect_to root_path
        end
      end
    end

    def set_employee_user
      @user = User.left_joins(:state, :city).select("users.*, states.name as state_name, cities.name as city_name").find(params[:id])
    end
  end
end
