Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  get "/page/:page" => "static_pages#show"
  resources :categories
  resources :questions do
    resources :answers
  end
  root "static_pages#show", page: "home"
  scope "(:locale)", locale: /en|vi/ do
    devise_for :users, controllers: {registrations: "registrations"}
  end
  resources :users, only: :show
  namespace :admin do
    resources :reports, only: :index
    resources :categories, except: :show
  end
  resources :questions, only: :show
  resources :reports, only: [:new, :create, :destroy]
  resources :votes, only: [:create, :destroy]
  resources :searches
  get "/category/:name", to: "categories#index"
  resources :tags
end
