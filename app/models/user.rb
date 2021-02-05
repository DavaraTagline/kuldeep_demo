# frozen_string_literal: true

# This model is for users.
class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :city
  belongs_to :state
  scope :employee_and_admin_users, -> { where(roles: { name: %w[employee admin] }) }
  scope :employee_users, -> { where(roles: { name: 'employee' }) }

  def admin?
    has_role?(:admin)
  end

  def employee?
    has_role?(:employee)
  end

  def superadmin?
    has_role?(:superadmin)
  end
end
