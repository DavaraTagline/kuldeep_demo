# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  get '/cities', to: 'home#index'
  resources :accountdetails

  get '/accountdetails/:user_id', to: 'accountdetails#index'
  namespace :admin do
    resources :users
  end

  namespace :employee do
    resources :users, only: %i[show]
  end

  namespace :superadmin do
    resources :users
  end
end
