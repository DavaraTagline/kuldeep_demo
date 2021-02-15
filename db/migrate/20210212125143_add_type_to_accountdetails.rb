class AddTypeToAccountdetails < ActiveRecord::Migration[6.1]
  def change
    add_column :accountdetails, :account_type, :text
  end
end
