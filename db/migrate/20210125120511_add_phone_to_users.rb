# frozen_string_literal: true

# This migration file is for add phone to user.
class AddPhoneToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :phone, :text
  end
end
