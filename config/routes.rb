# frozen_string_literal: true

Rails.application.routes.draw do
  get 'related_posts', to: 'related_posts#index'
  get 'dashboard', to: 'home#index'

  resources :criteria

  resources :administrative_units

  resources :companies do
    resources :owners, controller: 'company/owners'
  end

  resources :submissions do
    member do
      patch :move_image, controller: 'submissions/attachment_positions'
      get 'forms/register/new', to: 'submission/register_form#new'
      post 'forms/register', to: 'submission/register_form#create'
    end
  end

  resources :assessments do
    resources :scores, controller: 'assessments/scores'
    member do
      patch :move_image, controller: 'assessments/attachment_positions'
      post :submit, to: 'assessments#submit'
    end
  end

  resources :final_assessments, only: %i[show edit update]

  resources :panel_submissions do
    resources :assessments, controller: 'panel_submissions/assessments' do
      member do
        post :submit, to: 'panel_submissions/assessments#submit'
      end
    end
    get 'differences', to: 'panel_submissions/differences#index'
    delete 'differences', to: 'panel_submissions/differences#destroy'
  end

  resources :assistant_submissions do
    resources :assessments, controller: 'assistant_submissions/assessments' do
      member do
        post :approve, to: 'assistant_submissions/assessments#approve'
      end
    end
  end

  resources :scores do
    resources :evidences, controller: 'scores/evidences' do
      member do
        patch :move_image, to: 'scores/evidences#move_image'
      end
    end
  end

  resources :councils do
    resources :members, controller: 'councils/members'
  end

  get :criteria_groups_selector, to: 'councils/criteria_groups_selector#index'

  resources :posts, only: %i[index show]
  resources :products, only: %i[index show]

  namespace :cms_admin do
    resources :posts
    resources :products
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

  resources :people, only: :show do
    scope module: 'people' do
      scope defaults: { person_id: 'me' } do
        resource :profiles
        resources :push_subscriptions do
          scope module: 'push_subscriptions' do
            resources :test_notifications, only: :create
          end
        end
      end
    end
  end

  direct :fresh_account_logo do |_options|
    route_for :account_logo, v: Current.account&.updated_at&.to_fs(:number)
  end

  get 'webmanifest'    => 'pwa#manifest'
  get 'service-worker' => 'pwa#service_worker'

  get 'up' => 'rails/health#show', as: :rails_health_check

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'posts#index'
end
