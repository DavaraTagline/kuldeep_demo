class AddCompanyAndUserToDepartment < ActiveRecord::Migration[6.1]
  def change
    add_reference :departments, :company
    add_reference :departments, :user
  end
end
