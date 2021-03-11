# frozen_string_literal: true

class Company < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders] 
  validates :name, presence: true
  validates :email, presence: true
  validates :website, presence: true
  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses, allow_destroy: true
  has_many :departments, dependent: :destroy
  has_many :users, through: :departments
end
