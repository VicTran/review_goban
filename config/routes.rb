Rails.application.routes.draw do

  get 'advance_searchs/index'

  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  root "static_pages#home"

  get "home" => "static_pages#home"

  namespace :admin do
    root "mains#index"
    resources :categories
    resources :products
    resources :users
    resources :main, only: :index
  end
  resources :products do
    resources :comments, only: [:create, :new, :destroy, :update]
  end
  resources :categories, only: [:index, :show]
  resources :searchs, only: :index
  resources :advance_searchs, only: :index
  resources :orders, only: [:new, :create]
  resources :guest_orders, only: [:new, :create, :edit, :update, :show]
  resources :carts
  resources :users, only: :show
  resources :bookmarks
end
