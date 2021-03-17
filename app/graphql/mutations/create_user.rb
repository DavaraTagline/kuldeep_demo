class Mutations::CreateUser < Mutations::BaseMutation
    argument :name, String, required: true
    argument :email, String, required: true
    argument :phone, String, required: true
    argument :gender, String, required: true
    argument :password, String, required: true

    field :user, Types::UserType, null: true
    field :message, String, null: true
    field :status, String, null: true

    def resolve(name:, email:, phone:, gender:, password:)
        user = User.new(name: name, email: email, phone: phone, gender: gender, password: password)
        if user.save
            {
                status: "Success",
                message: 'Created Successfully!',
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