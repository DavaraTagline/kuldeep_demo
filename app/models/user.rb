# frozen_string_literal: true

# This model is for users.
class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist
  belongs_to :city
  belongs_to :state
  has_many :accountdetails
  scope :employee_and_admin_users, -> { where(roles: { name: %w[employee admin] }) }
  scope :employee_users, -> { where(roles: { name: 'employee' }) }

  # def generate_jwt
  #   JWT.encode({id: id, exp: 24.hours.from_now.to_i}, Rails.application.secrets.secret_key_base)
  # end

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
