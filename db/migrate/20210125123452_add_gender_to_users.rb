# frozen_string_literal: true

# This migration file is for add gender to user.
class AddGenderToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :gender, :text
  end
end
