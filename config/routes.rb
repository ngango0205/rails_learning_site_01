Rails.application.routes.draw do
  root "static_pages#home"

  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/search", to: "lessons#search", as: "search"

  resources :users do
    resources :notifications, only: :index
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
