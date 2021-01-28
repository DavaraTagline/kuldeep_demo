# frozen_string_literal: true

# This model used to store state in Database.
class State < ApplicationRecord
  has_many :cities
end
