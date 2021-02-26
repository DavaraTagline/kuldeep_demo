# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :addresses, dependent: :destroy
  accepts_nested_attributes_for :addresses, allow_destroy: true
  has_many :departments
  has_many :users, through: :departments
end
