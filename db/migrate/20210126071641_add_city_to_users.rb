class AddCityToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :city, :integer
  end
end
