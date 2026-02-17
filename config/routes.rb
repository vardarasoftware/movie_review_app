require "sidekiq/web"
Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  get 'homes/index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  #resources :admins
  resources :genres
  #resources :ratings
  #resources :reviews
  resources :movies do
    resources :ratings, only: [:create, :update, :destroy]
    resources :reviews, only: [:create, :update, :destroy]
  end
  resources :users, only: [:show, :edit, :update]
  #resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  #root "movies#index"
  root "homes#index"

  # Defines the root path route ("/")
  # root "posts#index"
end
