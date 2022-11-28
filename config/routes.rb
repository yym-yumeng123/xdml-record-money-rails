Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/me", to: "users#me"

  resources :users

  resources :sessions, only: [:create, :destroy]
end
