# frozen_string_literal: true

module Admin
  # This controller is for AdminUser
  class UsersController < ApplicationController
    before_action :authenticate_user!, except: %i[new create]
    before_action :set_admin_user, only: %i[show edit update destroy]
    def index
      @users = User.includes(:state, :city, :roles).employee_users
    end

    def show; end

    def new
      @user = User.new
    end

    def create
      @user = User.new(admin_params)
      @user.add_role :employee
      if @user.save
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
      if params[:commit] == 'Update'
        params.require(:user).permit(:name, :email, :phone, :gender, :state_id, :city_id)
      else
        params.require(:user).permit(:name, :email, :phone, :gender, :state_id, :city_id, :password,
                                     :password_confirmation)
      end
    end

    def set_admin_user
      @user = User.find(params[:id])
    end
  end
end
