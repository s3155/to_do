Rails.application.routes.draw do
  # Devise routes for users
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Google OAuth2 callback route
  devise_scope :user do
    get '/users/auth/google/callback', to: 'users/omniauth_callbacks#google_oauth2'
  end

  # Defines the root path route ("/")
  # root "posts#index"
  resources :lists
end