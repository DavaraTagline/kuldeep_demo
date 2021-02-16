module Api
    module V1
        class UsersController < ApplicationController
            skip_before_action :verify_authenticity_token
            before_action :set_user, only: %i[show update destroy]
            def index
                @users = User.all
            end
            
            def show; end

            def create
                @user = User.new(user_params)
                if @user.save
                    render json: {status: 'Success', data: @user}
                else
                    render json: {status: 'Error', data: @user.errors}
                end
            end

            def update
                if @user.update(user_params)
                    render json: {status: 'Updated', data: @user}
                else
                    render json: {status: 'Error', data: @user.errors}
                end
            end

            def destroy
                if @user.destroy
                    render json: {status: 'Deleted successfully'}
                else
                    render json: {status: 'There is something wrong!'}
                end            
            end

            private

            def user_params
                base_params = params.require(:user).permit(:name, :email, :phone, :gender, :state_id, :city_id)
                if action_name == 'update'
                    base_params
                else
                    password = params.dig('user', 'password')
                    base_params.merge(password: password)
                end
            end

            def set_user
                @user = User.find(params[:id])
            end
        end
    end
end