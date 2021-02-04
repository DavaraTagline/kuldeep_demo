# frozen_string_literal: true

module Admin
  # This controller is for AdminUser
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_admin_user, only: %i[show edit update destroy]
    load_and_authorize_resource except: :create
    def index
      @users = User.includes(:state, :city, :roles).employee_users
    end

    def show; end

    def new
      @user = User.new
    end

    def create
      @user = User.new(admin_params)
      if @user.save
        @user.add_role :employee
        redirect_to admin_users_path
      else
        render :new
      end
    end

    def edit; end

    def update
      if @user.update(admin_params)
        redirect_to admin_users_path, notice: 'updated succesfully'
      else
        render :edit
      end
    end

    def destroy
      @user.destroy
      redirect_to admin_users_path
    end

    private

    def admin_params
      base_params = params.require(:user).permit(:name, :email, :phone, :gender, :state_id, :city_id)
      unless action_name == 'update'
        password = params.dig('user', 'password')
        password_confirmation = params.dig('user', 'password_confirmation')
        base_params.merge(password: password, password_confirmation: password_confirmation)
      end
    end

    def set_admin_user
      @user = User.find(params[:id])
    end
  end
end
