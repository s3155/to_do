Rails.application.routes.draw do
  # Devise routes for users
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check


  root to: 'lists#index'


  # Google OAuth2 callback route
  devise_scope :user do
    get "/" => "devise/sessions#new"
  end

  # Define nested resources for items within lists
  resources :lists do
    resources :items
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
