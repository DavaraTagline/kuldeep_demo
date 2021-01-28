# frozen_string_literal: true

# This is application record for ORM.
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
