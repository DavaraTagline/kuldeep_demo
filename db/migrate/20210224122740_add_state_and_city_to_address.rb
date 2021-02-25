class AddStateAndCityToAddress < ActiveRecord::Migration[6.1]
  def change
    add_reference :addresses, :state, null: false, foreign_key: true
    add_reference :addresses, :city, null: false, foreign_key: true
  end
end
