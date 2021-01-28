# frozen_string_literal: true

# This migration file for creating State model.
class CreateStates < ActiveRecord::Migration[6.1]
  def change
    create_table :states do |t|
      t.string :name

      t.timestamps
    end
  end
end
