class RemoveStateAndCityFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :state, :integer
    remove_column :users, :city, :integer
  end
end
