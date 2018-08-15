Rails.application.routes.draw do
  root "static_pages#home"

  get "/user_home", to: "static_pages#user_home"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/search", to: "lessons#search", as: "search"
  get "/notifications", to: "notifications#update_seen"
  get "/notifications/all", to: "notifications#index"
  get "/notifications/refresh_part", to: "notifications#refresh_part"

  devise_for :users, controllers:{
    omniauth_callbacks: "users/omniauth_callbacks"}

  resources :users, only: [:index, :show] do
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
  mount ActionCable.server => "/cable"
end
