class CreateAccountDetail
  attr_reader :accountdetail, :current_user

  def initialize(accountdetail, current_user)
    @accountdetail = accountdetail
    @current_user = current_user
  end

  def call
    @accountdetail.account_type = if current_user.has_role?(:superadmin) || current_user.has_role?(:admin)
                                    'company'
                                  else
                                    'personal'
                                  end
    return nil unless @accountdetail.save

    @accountdetail
  end

  private

  def account_detail_params
    params.require(:accountdetail).permit(:user_id, :branch_name, :account_number, :account_name, :account_type,
                                          :image)
  end
end
