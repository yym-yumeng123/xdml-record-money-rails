Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/me", to: "users#me"
  delete "/sessions", to: "sessions#destroy"

  resources :users
  resources :sessions, only: [:create]
  resources :records
end
