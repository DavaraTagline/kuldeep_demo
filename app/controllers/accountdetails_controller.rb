class AccountdetailsController < ApplicationController
  load_and_authorize_resource param_method: :account_detail_params
  before_action :set_account_detail, only: %i[show edit update destroy]
  
  def index
    @accountdetails = Accountdetail.where(user_id: params[:user_id])
  end

  def show; end

  def new
    @accountdetail = Accountdetail.new
    @accountdetail.user_id = params[:user_id]
  end

  def create
    accountdetail = CreateAccountDetail.new(Accountdetail.new(account_detail_params), current_user).call
    if accountdetail
      redirect_to accountdetails_path
    else
      render :new
    end
    # @accountdetail = Accountdetail.new(account_detail_params)
    # if current_user.has_role? :superadmin or current_user.has_role? :admin
    #     @accountdetail.account_type = "company"
    # else
    #     @accountdetail.account_type = "personal"
    # end
    # if @accountdetail.save
    #     redirect_to accountdetails_path
    # else
    #     render :new
    # end
  end

  def edit; end

  def update
    if @accountdetail.update(account_detail_params)
      redirect_to accountdetail_path
    else
      render :edit
    end
  end

  def destroy
    @accountdetail.destroy
    redirect_to accountdetails_path
  end

  private

  def account_detail_params
    params.require(:accountdetail).permit(:user_id, :branch_name, :account_number, :account_name, :account_type,
                                          :image)
  end

  def set_account_detail
    @accountdetail = Accountdetail.find(params[:id])
  end
end
