Rails.application.routes.draw do
  root 'static_pages#home'

  get "up" => "rails/health#show", as: :rails_health_check

  # Static pages
  get '/team', to: 'static_pages#team'
  get '/contact', to: 'static_pages#contact'
  get '/welcome/:first_name', to: 'static_pages#welcome'

  # Gossips
  get '/gossips', to: 'gossips#index'
  get '/gossips/:id', to: 'gossips#show', as: 'gossip'

  # Users
  get '/users/:id', to: 'users#show', as: 'user'
end
