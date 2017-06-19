Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  get "/page/:page" => "static_pages#show"
  resources :categories
  resources :questions do
    resources :answers
  end
  root "static_pages#show", page: "home"
  resources :users, only: :show
  namespace :admin do
    resources :reports, only: :index
    resources :categories, except: :show
    resources :users, only: :index
    resources :questions, only: :index
  end
  resources :questions, only: :show
  resources :reports, only: [:new, :create, :destroy]
  resources :votes, only: [:create, :destroy]
  resources :searches
  get "/category/:name", to: "categories#index"
  resources :tags
  resources :notifications, only: :update
  devise_for :users, controllers: {omniauth_callbacks:
    "users/omniauth_callbacks"}

  devise_scope :user do
    get "sign_in", :to => "devise/sessions#new"
    get "sign_out", :to => "devise/sessions#destroy"
  end
end
