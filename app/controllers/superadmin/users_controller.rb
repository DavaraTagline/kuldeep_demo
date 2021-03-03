# frozen_string_literal: true

# This conntroller used to display userdetails
module Superadmin
  # This controller is for SuperadminUser
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :restrict_user
    before_action :set_superadmin_user, only: %i[show edit update destroy]
    load_and_authorize_resource param_method: :superadmin_params
    def index
      @users = User.left_joins(:roles,:state,:city).select("users.*, states.name as state_name, cities.name as city_name").employee_and_admin_users
    end

    def show; end

    def new
      @user = User.new
    end

    def create
      @user = User.new(superadmin_params)
      if @user.save
        @user.add_role params.dig('user', 'role')
        redirect_to superadmin_users_path
      else
        render :new
      end
    end

    def edit; end

    def update
      if @user.update(superadmin_params)
        redirect_to superadmin_users_path, notice: 'updated succesfully'
      else
        render :edit
      end
    end

    def destroy
      @user.destroy
      redirect_to superadmin_users_path
    end

    private

    def superadmin_params
      base_params = params.require(:user).permit(:name, :email, :phone, :gender, :state_id, :city_id,:company_id,:department_id)
      if action_name == 'update'
        base_params
      else
        password = params.dig('user', 'password')
        password_confirmation = params.dig('user', 'password_confirmation')
        base_params.merge(password: password, password_confirmation: password_confirmation)
      end
    end

    def restrict_user
      unless current_user.has_role? :superadmin
        if current_user.has_role? :admin
          redirect_to admin_users_path
        elsif current_user.has_role? :employee
          redirect_to employee_user_path(current_user)
        else
          redirect_to root_path
        end
      end
    end

    def set_superadmin_user
      @user = User.left_joins(:state, :city).select("users.*, states.name as state_name, cities.name as city_name").find(params[:id])
    end
  end
end
