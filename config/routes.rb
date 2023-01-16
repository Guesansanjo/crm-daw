# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'home#index'
  get 'dashboard', to: 'dashboard#index'

  resources :boards do
    resources :lists, except: :show
    resources :board_users, except: :show
  end

  resources :lists do
    resources :items
  end

  

  namespace :api do
    resources :boards do
      resources :lists, only: %i[index], controller: 'lists'
      resources :list_positions, only: %i[index update], controller: 'list_positions'
    end
    resources :item_positions, only: :update, controller: 'item_positions'
    put 'item_positions', to: 'item_positions#update'

    resources :items, only: :show
  end
end
