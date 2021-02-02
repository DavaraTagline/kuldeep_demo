# frozen_string_literal: true

# This model is for users.
class User < ApplicationRecord
  rolify
  after_create :assign_default_role
  belongs_to :city
  belongs_to :state
  scope :get_susers, -> {where(roles:{name:["employee","admin"]})}
  scope :get_ausers, -> {where(roles: {name:"employee"})}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def assign_default_role
    self.add_role(:employee) if self.roles.blank?
  end
  
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
