# frozen_string_literal: true

# This model is for users.
class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,:validatable, :omniauthable, omniauth_providers: [:google_oauth2, :facebook]
  before_create :assign_default_role
  belongs_to :city, optional: true
  belongs_to :state, optional: true
  belongs_to :company, optional: true
  belongs_to :department, optional: true
  has_many :accountdetails, inverse_of: :user
  accepts_nested_attributes_for :accountdetails, allow_destroy: true
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX }
  validates :phone, presence: true
  validates :gender, presence: true
  scope :employee_and_admin_users, -> { where(roles: { name: %w[employee admin] }) }
  scope :employee_users, -> { where(roles: { name: 'employee' }) }

  def generate_jwt
    JWT.encode({ id: id, exp: 24.hours.from_now.to_i }, Rails.application.secrets.secret_key_base)
  end

  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_initialize do | user |
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = provider_data.info.name
      user.save!
    end
  end
  
  def assign_default_role
    add_role(:employee)
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
