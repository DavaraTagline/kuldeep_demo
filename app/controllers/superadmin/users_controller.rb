# frozen_string_literal: true

# This conntroller used to display userdetails
module Superadmin
  # This controller is for SuperadminUser
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_superadmin_user, only: %i[show edit update destroy]
    load_and_authorize_resource except: :create
    def index
      @users = User.includes(:state, :city, :roles).employee_and_admin_users
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
      base_params = params.require(:user).permit(:name, :email, :phone, :gender, :state_id, :city_id)
      unless action_name == 'update'
        password = params.dig('user', 'password')
        password_confirmation = params.dig('user', 'password_confirmation')
        base_params.merge(password: password, password_confirmation: password_confirmation)
      end
    end

    def set_superadmin_user
      @user = User.find(params[:id])
    end
  end
end
