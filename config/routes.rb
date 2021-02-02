# frozen_string_literal: true

Rails.application.routes.draw do
  #get 'userdetails/index'
  #get 'userdetails/:id', to:'userdetails#show'
  resources :user
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
end
