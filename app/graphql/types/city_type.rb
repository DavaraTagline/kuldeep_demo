module Types
  class CityType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :state_id, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
