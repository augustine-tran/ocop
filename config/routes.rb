# frozen_string_literal: true

Rails.application.routes.draw do
  resources :criteria

  resources :administrative_units

  resources :companies do
    resources :products, controller: 'companies/products'
  end

  resources :submissions

  resources :assessments do
    resources :scores, controller: 'assessments/scores'
    member do
      patch :move_image, controller: 'assessments/attachment_positions'
      post :submit, to: 'assessments#submit'
    end
  end

  resources :final_submissions do
    resources :assessments, controller: 'final_submissions/assessments' do
      member do
        post :submit, to: 'final_submissions/assessments#submit'
      end
    end
    get 'differences', to: 'final_submissions/differences#index'
  end

  resources :panel_submissions

  resources :scores do
    resources :evidences, controller: 'scores/evidences' do
      member do
        patch :move_image, to: 'scores/evidences/move_image'
      end
    end
  end

  resources :concils do
    resources :members
  end

  resources :prompts

  get  'admin_home', to: 'admin_home#index'
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
