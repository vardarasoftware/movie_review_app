Rails.application.routes.draw do
  resources :admins
  resources :genres
  resources :ratings
  resources :comments
  resources :movies
  #resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  devise_for :users
  root "home#index"

  # Defines the root path route ("/")
  # root "posts#index"
end
