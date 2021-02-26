# frozen_string_literal: true

Rails.application.routes.draw do
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
    resources :users
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
end
