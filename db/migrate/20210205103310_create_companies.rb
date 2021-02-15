# frozen_string_literal: true

class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.text :name
      t.text :email
      t.text :website

      t.timestamps
    end
  end
end
