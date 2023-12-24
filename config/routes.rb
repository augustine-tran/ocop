# frozen_string_literal: true

Rails.application.routes.draw do
  resources :criteria

  resources :administrative_units

  resources :companies do
    resources :products, controller: 'companies/products'
  end

  resources :submissions do
    resources :scores, controller: 'submissions/scores'
  end

  resources :prompts

  get  'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  get  'test', to: 'registrations#index'
  get  'sign_up', to: 'registrations#new'
  post 'sign_up', to: 'registrations#create'
  resources :sessions, only: %i[index show destroy]
  resource  :password, only: %i[edit update]

  namespace :identity do
    resource :email,              only: %i[edit update]
    resource :email_verification, only: %i[show create]
    resource :password_reset,     only: %i[new edit create update]
  end

  root 'home#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
