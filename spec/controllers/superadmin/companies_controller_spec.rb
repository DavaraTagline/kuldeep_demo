require 'rails_helper'

RSpec.describe Superadmin::CompaniesController, type: :controller do
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
            @company = Company.find_by(name:'test')
            get :edit, params: {id: @company.id}
            expect(response).to render_template(:edit)
        end
    end

    context "for POST#create" do
        it "should create company when params is valid" do
            post :create, params: { company: {name:'testing_create', email:'a@gmail.com', website:'https://www.sample.com'} }
            #expect(response).to redirect_to superadmin_companies_path
            expect(Company.last.name).to eq("testing_create")
        end

        it "should not create company when params is not valid" do
            post :create, params: { company: {name:'', email:'a@gmail.com', website:''} }
            expect(response).to render_template(:new)
        end
    end

    context "for GET#show" do
        it "should show company" do
            @company = Company.find_by(name:'test')
            get :show, params: { id: @company.id}
            expect(response).to render_template(:show)
        end
    end

    context "for PUT#update" do
        it "should update company" do
            @company = Company.find_by(name:'test')
            put :update, params: { id: @company.id, company: { name: 'updated_test'} }
            #expect(response).to redirect_to superadmin_companies_path
            expect(Company.last.name).to eq("updated_test")
        end

        it "should not update company when params is not valid" do
            @company = Company.find_by(name:'test')
            put :update, params: { id: @company.id, company: { name: ' '} }
            expect(response).to render_template(:edit)
        end
    end

    context "for DELETE#destroy" do
        it "should delete company" do
            @company = Company.find_by(name:'test')
            expect{ delete :destroy, params: { id: @company.id } }.to change { Company.count }.by(-1)
            expect(response).to redirect_to superadmin_companies_path
        end
    end
end