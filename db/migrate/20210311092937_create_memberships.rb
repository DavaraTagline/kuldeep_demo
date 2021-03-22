class CreateMemberships < ActiveRecord::Migration[6.1]
  def change
    create_table :memberships do |t|
      t.boolean :paid, default: false
      t.string :token
      t.integer :price
      t.references :user, index: true
      t.timestamps
    end
  end
end
