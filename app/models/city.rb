# frozen_string_literal: true

# This model used to store city in Database.
class City < ApplicationRecord
  belongs_to :state
  has_many :users
end
