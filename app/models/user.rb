# frozen_string_literal: true

# This model is for users.
class User < ApplicationRecord
  rolify
  after_create :assign_default_role
  belongs_to :city
  belongs_to :state
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def assign_default_role
    add_role(:employee) if roles.blank?
  end
end
