Rails.application.routes.draw do
  root "static_pages#home"

  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/search", to: "lessons#search"

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :lessons do
    resources :comments
  end

  resources :user_relations, only: [:create, :destroy]
end
