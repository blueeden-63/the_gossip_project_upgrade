Rails.application.routes.draw do
  root 'static_pages#home'

  get "up" => "rails/health#show", as: :rails_health_check

  # Static pages
  get '/team', to: 'static_pages#team'
  get '/contact', to: 'static_pages#contact'
  get '/welcome/:first_name', to: 'static_pages#welcome'

  # Gossips
  resources :gossips, only: [:index, :show, :new, :create]

  # Users
  resources :users, only: [:show]
end
