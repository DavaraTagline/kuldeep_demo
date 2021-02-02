# frozen_string_literal: true

Rails.application.routes.draw do
  #resources :user
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
<<<<<<< HEAD
  get '/cities', to: 'home#index'
=======
  namespace :admin do 
    resources :users
  end

  namespace :employee do
    resources :users
  end
  
  namespace :superadmin do
    resources :users
  end
>>>>>>> 29ccb29 (namespace_controller_and_routes_added)
end
