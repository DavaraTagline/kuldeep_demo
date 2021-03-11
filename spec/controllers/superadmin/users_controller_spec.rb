require 'rails_helper'

RSpec.describe Superadmin::UsersController, type: :controller do
    
    before(:each) do
        @super_admin = Role.find_by(name: 'superadmin').users.last
        sign_in @super_admin
    end

    context "for render" do
        it "should render index page" do
            get :index
            expect(response).to render_template(:index)
        end

        it "should render new page" do
            get :new
            expect(response).to render_template(:new)
        end

        it "should render edit page" do
            @user = User.create(name: "test", email: 'test@gmail.com', phone:'123456789', gender:'male', password: '12345678')
            get :edit, params: {id: @user.id}
            expect(response).to render_template(:edit)
        end
    end

    context "for POST#create" do
        it "should create user when params is valid" do
            post :create, params: { user: {name: 'testing_create', email: 'a@gmail.com', phone:'7894561231', gender: 'female', password: '987654321' } }
            #expect(response).to redirect_to superadmin_users_path
            expect(User.last.name).to eq("testing_create")
        end

        it "should not create user when params is not valid" do
            post :create, params: { user: {name: 'testing_create', email: 'abcd', phone:'7894561231', gender: 'female', password: '987654321' } }
            expect(response).to render_template(:new)
        end
    end

    context "for GET#show" do
        it "should show user" do
            @user = User.find_by(name:'kuldeep')
            get :show, params: { id: @user.id}
            expect(response).to render_template(:show)
        end
    end

    context "for PUT#update" do
        it "should update user when params is valid" do
            @user = User.find_by(name:'kuldeep')
            put :update, params: { id: @user.id, user: { name: 'updated_kuldeep' } }
            #expect(response).to redirect_to superadmin_users_path
            expect(User.last.name).to eq("updated_kuldeep")
        end

        it "should not update user when params is not valid" do
            @user = User.find_by(name:'kuldeep')
            put :update, params: { id: @user.id, user: { email: 'abc' } }
            expect(response).to render_template(:edit)
        end
    end

    context "for DELETE#destroy" do
        it "should delete user" do
            @user = User.find_by(name:'kuldeep')
            expect{ delete :destroy, params: { id: @user.id } }.to change { User.count }.by(-1)
            expect(response).to redirect_to superadmin_users_path
        end
    end
end