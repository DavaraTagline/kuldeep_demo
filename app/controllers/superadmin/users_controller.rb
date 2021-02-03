# frozen_string_literal: true

# This conntroller used to display userdetails
module Superadmin
  # This controller is for SuperadminUser
  class UsersController < ApplicationController
    before_action :authenticate_user!, only: %i[index show edit update destroy]
    before_action :superadmin_user, only: %i[show edit update destroy]
    def index
      @users = User.includes(:state, :city, :roles).get_all_users
    end

    def show; end

    def new
      @user = User.new
    end

    def create
      @user = User.new(params.require(:user).permit(:name, :email, :phone, :gender, :state_id, :city_id, :password,
                                                    :password_confirmation))
      puts @user.inspect
      if @user.save
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
      params.require(:user).permit(:name, :email, :phone, :gender, :state_id, :city_id)
    end

    def superadmin_user
      @user = User.find(params[:id])
    end
  end
end
