Rails.application.routes.draw do
  get 'homes/index'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }, path: 'auth'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root to: 'lists#index'
  root 'homes#index'
  # Define nested resources for items within lists
  resources :lists do
    resources :items
  end

  # GitHub認証のコールバックURLに対するルートを追加
  devise_scope :user do
    get '/auth/github/callback', to: 'users/omniauth_callbacks#github'
    post '/auth/github', to: 'users/omniauth_callbacks#github'
  end
  
end
