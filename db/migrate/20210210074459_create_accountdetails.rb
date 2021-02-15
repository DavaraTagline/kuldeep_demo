class CreateAccountdetails < ActiveRecord::Migration[6.1]
  def change
    create_table :accountdetails do |t|
      t.references :user, null: false, foreign_key: true
      t.text :branch_name
      t.integer :account_number
      t.text :account_name

      t.timestamps
    end
  end
end
