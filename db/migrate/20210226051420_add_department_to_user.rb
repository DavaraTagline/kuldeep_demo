class AddDepartmentToUser < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :department
  end
end
