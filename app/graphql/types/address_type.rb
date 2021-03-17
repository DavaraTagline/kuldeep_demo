module Types
  class AddressType < Types::BaseObject
    field :id, ID, null: false
    field :company_id, Integer, null: false
    field :address, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :state, Types::StateType, null: false
    field :city, Types::CityType, null: false
  end
end
