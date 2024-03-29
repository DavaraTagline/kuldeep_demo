# frozen_string_literal: true

Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  devise_for :users,controllers: { omniauth_callbacks: 'omniauth' }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  get '/cities', to: 'home#getcities'
  resources :accountdetails, path: 'account_details' do
    collection do
      get 'accountdetails/:user_id', to: 'accountdetails#index', as: :details
    end
  end
  
  get '/companies', to: 'home#getdepartments'
  namespace :admin do
    resources :users
  end

  namespace :employee do
    resources :users, only: %i[show]
  end

  namespace :superadmin do
    resources :users do
      collection { post :import }
    end
    resources :companies do
      resources :departments
    end
  end

  namespace 'api' do
    namespace 'v1' do
      devise_for :users, defaults: { format: :json },
                         controllers: { sessions: 'api/v1/api_sessions', registrations: 'api/v1/api_registrations' }
      resources :users, except: %i[new edit]
    end
  end
  resources :memberships, only: %i[new]
  post :create_order, to: 'memberships#create_order'
  post :capture_order, to: 'memberships#capture_order'

  get '/users', to: 'posts#users'
  post 'users/:id/posts', to: 'posts#save_post'
  post 'users/:id/post', to: 'posts#create_post'
end
