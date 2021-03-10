# frozen_string_literal: true

class Company < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders] 
  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses, allow_destroy: true
  has_many :departments, dependent: :destroy
  has_many :users, through: :departments
end
