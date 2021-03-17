module Types
    class PostAttributes < Types::BaseInputObject
        argument :name, String, required: false
        argument :email, String, required: false
        argument :phone, String, required: false
        argument :gender, String, required: false
    end
end