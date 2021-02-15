# frozen_string_literal: true

class RemoveStateIdAndCityIdFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :state_id, :integer
    remove_column :users, :city_id, :integer
  end
end
