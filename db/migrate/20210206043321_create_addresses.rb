# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.references :company, null: false, foreign_key: true
      t.text :address

      t.timestamps
    end
  end
end
