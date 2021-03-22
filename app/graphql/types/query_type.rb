module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    #listing all users
    field :all_users, [Types::UserType], null: false,
      description: "A list of all users"
    def all_users
      #User.includes(:state, :city, :company, :accountdetails).all
      User.includes(:accountdetails).left_joins(:roles,:state,:city,:company).select("users.*, states.name as state_name, cities.name as city_name, companies.name as company_name")
    end

    #display single user
    field :user, Types::UserType, null: false do
      argument :id, ID, required: true
    end

    def user(id:)
      User.find(id)
    end

    #all companies
    field :companies, [Types::CompanyType], null: false

    def companies
      #Company.includes(:departments, addresses: [:state, :city]).all
      #Company.includes(:departments).joins(addresses:[:state,:city]).select("companies.*,CONCAT(addresses.address,',',cities.name,',',states.name) as address")
      Company.joins(:departments, addresses:[:state,:city]).select("companies.*,array_agg(DISTINCT departments.name) as department, array_agg(DISTINCT CONCAT(addresses.address,',',cities.name,',',states.name)) as address").group("id")
    end

  end
end
