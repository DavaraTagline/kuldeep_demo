# frozen_string_literal: true

# This migration file is for add name to user.
class AddNameToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
  end
end
