# frozen_string_literal: true

# This conntroller used to display userdetails
module Admin
class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  def index
    @users = User.includes(:state, :city,:roles).get_ausers
  end
  
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params.require(:user).permit(:name,:email,:phone,:gender,:state_id,:city_id))
      redirect_to admin_users_path, notice: "updated succesfully"
    else
      render :edit
    end

  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end
end
end