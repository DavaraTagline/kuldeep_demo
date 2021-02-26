class RemoveUserToDepartment < ActiveRecord::Migration[6.1]
  def change
    remove_reference :departments, :user
  end
end
