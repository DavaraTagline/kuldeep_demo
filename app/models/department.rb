class Department < ApplicationRecord
    has_many :users, dependent: :nullify
    belongs_to :company
end
