# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'home#index'
  get 'dashboard', to: 'dashboard#index'
  resources :boards, only: %i[new edit show create update destroy]

  namespace :api do
    resources :boards do
      resources :lists, only: :index, controller: 'lists'
    end
  end
end
