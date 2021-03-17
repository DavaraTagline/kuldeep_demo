module Types
  class CompanyType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :email, String, null: true
    field :website, String, null: true
    field :department, [String], null: false
    field :address, [String], null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :slug, String, null: true
  end
end
