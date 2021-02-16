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
                    success_json(@user,"Created Successfully!",200)
                else
                    err_json("something went wrong!",422,@user.errors)
                end
            end

            def update
                if @user.update(user_params)
                    success_json(@user,"Updated Successfully!",200)
                else
                    err_json("something went wrong!",422,@user.errors)
                end
            end

            def destroy
                if @user.destroy
                    success_json(@user,"Deleted Successfully!",200)
                else
                    err_json("something went wrong!",422,@user.errors)
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