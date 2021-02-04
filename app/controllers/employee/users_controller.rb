# frozen_string_literal: true

# This conntroller used to display userdetails
module Employee
  # This controller is for EmployeeUser
  class UsersController < ApplicationController
    before_action :authenticate_user!, except: %i[new create]
    before_action :set_employee_user, only: %i[show edit update destroy]
    def index
      @user = current_user
    end

    def show; end

    def edit; end

    def update
      if @user.update(employee_params)
        redirect_to employee_users_path, notice: 'updated succesfully'
      else
        render :edit
      end
    end

    def destroy
      @user.destroy
      redirect_to employee_users_path
    end

    private

    def employee_params
      params.require(:user).permit(:name, :email, :phone, :gender, :state_id, :city_id)
    end

    def set_employee_user
      @user = User.find(params[:id])
    end
  end
end
