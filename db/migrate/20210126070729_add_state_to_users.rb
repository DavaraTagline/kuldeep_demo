# frozen_string_literal: true

# This migration file is for add state to user.
class AddStateToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :state, :integer
  end
end
