Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
  }
  #get 'homes/index'
 #root to: redirect('/users/sign_in') # ログインページにリダイレクトする
  root 'lists#index'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Define nested resources for items within lists
  resources :lists do
    resources :items
  end

  resources :items, only: [:create, :new, :index, :show, :edit, :update, :destroy]

  # GitHub認証のコールバックURLに対するルートを追加
  # devise_scope :user do
  #   get '/auth/github/callback', to: 'users/omniauth_callbacks#github'
  #   post '/auth/github', to: 'users/omniauth_callbacks#github'
  # end
end
