class RemoveNullFromStateAndCity < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :state_id, true
    change_column_null :users, :city_id, true
  end
end
