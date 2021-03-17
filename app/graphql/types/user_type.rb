module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :encrypted_password, String, null: false
    field :reset_password_token, String, null: true
    field :reset_password_sent_at, GraphQL::Types::ISO8601DateTime, null: true
    field :remember_created_at, GraphQL::Types::ISO8601DateTime, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :name, String, null: true
    field :phone, String, null: true
    field :gender, String, null: true
    field :state_name, String, null: true
    field :city_name, String, null: true
    field :accountdetails, [Types::AccountdetailType], null: false
    field :provider, String, null: false
    field :uid, String, null: false
    field :company_name, String, null:true
    field :department_id, Integer, null: true
    field :slug, String, null: true
    field :discarded_at, GraphQL::Types::ISO8601DateTime, null: true
  end
end
