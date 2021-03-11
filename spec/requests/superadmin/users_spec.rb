require 'rails_helper'

RSpec.describe "Users", type: :request do
  
  let(:super_admin) { create(:superadmin_user) }
  let(:user) { create(:user) }
  before(:each) do
    sign_in(super_admin) 
  end

  it "show all users" do
    get superadmin_users_path
    expect(response).to have_http_status(200)
    expect(response.body).to include(user.name)
  end

  it "show user by id" do
    get superadmin_user_path(user)
    expect(response).to have_http_status(200)
    expect(response.body).to include(user.name)
  end

  it "create user" do
    get new_superadmin_user_path
    expect(response).to render_template(:new)
    post "/superadmin/users", params: { user: {name: 'testing_create', email: 'a@gmail.com', phone:'7894561231', gender: 'female', password: '987654321' } }
    expect(response).to redirect_to superadmin_users_path
  end

  it "update user" do
    get edit_superadmin_user_path(user)
    expect(response).to render_template(:edit)
    put "/superadmin/users/#{user.id}", params: { id: user.id, user: { name: 'updated_test' } }
    expect(response).to redirect_to superadmin_users_path
    expect(User.last.name).to eq("updated_test") 
  end
  
  it "delete user" do
    delete "/superadmin/users/#{user.id}", params: { id: user.id }
    expect(response).to redirect_to superadmin_users_path
    follow_redirect!
    expect(response).to have_http_status(200)
  end
end