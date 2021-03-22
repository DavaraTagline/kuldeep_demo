module Types
  class AccountdetailType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer, null: false
    field :branch_name, String, null: true
    field :account_number, Integer, null: true
    field :account_name, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :account_type, String, null: true
  end
end
