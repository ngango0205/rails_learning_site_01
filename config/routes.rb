Rails.application.routes.draw do
  root "static_pages#home"

  get "/user_home", to: "static_pages#user_home"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/search", to: "lessons#search", as: "search"
  get "/notifications", to: "notifications#update_seen"

  resources :users do
    resources :notifications, only: [:index, :update, :destroy]
    member do
      get :following, :followers
    end
  end

  resources :lessons do
    resources :comments
    resource :like, module: :lessons
  end

  resources :categories
  resources :user_relations, only: [:create, :destroy]
end
