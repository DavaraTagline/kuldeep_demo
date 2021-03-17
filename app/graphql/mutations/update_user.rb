class Mutations::UpdateUser < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :attributes, Types::PostAttributes, required: true

    field :user, Types::UserType, null: true
    field :message, String, null: true
    field :status, String, null: true

    def resolve(id:, attributes:)
        user = User.find(id)
        if user.update(attributes.to_h)
            {
                status: "Success",
                message: 'Updated Successfully!',
                user: user,
                errors: []
            }
        else
            build_errors(user)
            return
        end
    end

     def build_errors(user)
      user.errors.map do |attr, message|
        message = attr.to_s + ' ' + message
        context.add_error(GraphQL::ExecutionError.new(message, extensions: { code: 'USER_INPUT_ERROR', attribute: attr }))
      end
    end
end