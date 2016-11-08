Rails.application.routes.draw do
  get 'search/index'

  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users
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
    resources :comments, only: [:create, :new, :destroy]
  end
  resources :categories, only: [:index, :show]
  resources :searchs, only: :index
end
