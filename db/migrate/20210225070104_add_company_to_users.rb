class AddCompanyToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :company
  end
end