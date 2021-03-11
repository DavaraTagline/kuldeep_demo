# frozen_string_literal: true

module Admin
  # This controller is for AdminUser
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_admin_user, only: %i[show edit update destroy]
    before_action :restrict_user
    load_and_authorize_resource param_method: :admin_params
    def index
      @users = User.left_joins(:roles,:state,:city,:company).select("users.*, states.name as state_name, cities.name as city_name, companies.name as company_name").employee_users.kept
    end

    def show
      @accountdetails = Accountdetail.where("user_id = ?",@user.id)
    end

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
      base_params = params.require(:user).permit(:name, :email, :phone, :gender, :state_id, :city_id, :company_id, :department_id, 
                                                  accountdetails_attributes: [:id, :user_id, :branch_name, :account_number, :account_name, :image, :_destroy])
      if action_name == 'update'
        base_params
      else
        password = params.dig('user', 'password')
        password_confirmation = params.dig('user', 'password_confirmation')
        base_params.merge(password: password, password_confirmation: password_confirmation)
      end
    end

    def restrict_user
      unless current_user.has_role? :admin
        if current_user.has_role? :superadmin
          redirect_to superadmin_users_path
        elsif current_user.has_role? :employee
          redirect_to employee_user_path(current_user)
        else
          redirect_to root_path
        end
      end
    end

    def set_admin_user
      @user = User.joins(:state, :city).select("users.*, states.name as state_name, cities.name as city_name").find(params[:id])
    end
  end
end
