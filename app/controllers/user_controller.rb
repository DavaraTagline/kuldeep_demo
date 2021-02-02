# frozen_string_literal: true

# This conntroller used to display userdetails
class UserController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  load_and_authorize_resource
  def index
    @users = User.includes(:state, :city).all
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
      redirect_to user_index_path, notice: "updated succesfully"
    else
      render :edit
    end

  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to user_index_path
  end

end
