# frozen_string_literal: true

class AddStateAndCityToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :state, null: false, foreign_key: true
    add_reference :users, :city, null: false, foreign_key: true
  end
end
