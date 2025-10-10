Rails.application.routes.draw do
  devise_for :users
  get    '/admin/login',  to: 'admin_sessions#new'
  post   '/admin/login',  to: 'admin_sessions#create'
  delete '/admin/logout', to: 'admin_sessions#destroy'

  namespace :admin do
      # resources :admin_users
      resources :users
      resources :genres
      resources :movies
      resources :movie_genres
      resources :comments
      resources :ratings

      root to: "users#index"
    end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :movies, only: [:index, :show] do
    resources :comments, only: [:create]
    resources :ratings, only: [:create]
  end
  root "movies#index"
end
