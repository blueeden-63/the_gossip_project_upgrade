Rails.application.routes.draw do
  root 'static_pages#home'

  get "up" => "rails/health#show", as: :rails_health_check

  # Static pages
  get '/team', to: 'static_pages#team'
  get '/contact', to: 'static_pages#contact'
  get '/welcome/:first_name', to: 'static_pages#welcome'

  # Gossips
  resources :gossips do
  resources :comments, only: [:create]
  resource :like, only: [:create, :destroy]
  end


  # Users
  resources :users, only: [:new, :create, :show]

  # Cities
  resources :cities, only: [:show]

  # Comments
  resources :comments, only: [:edit, :update, :destroy]

  #Logins
  resource :session, only: [:new, :create, :destroy]
end
