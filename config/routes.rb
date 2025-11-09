Rails.application.routes.draw do
  # Authentication routes
  resource :session
  resource :registration, only: [:new, :create]
  resources :passwords, param: :token

  # Profile
  get "profile", to: "profile#show"

  # Public blog routes
  root "posts#index"
  resources :posts, only: [:index, :show], param: :slug do
    resources :comments, only: [:create, :destroy]
  end

  # Admin routes - protected by authentication
  namespace :admin do
    root "dashboard#index"
    resources :posts
    resources :categories
    resources :users, only: [:index]
  end

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
