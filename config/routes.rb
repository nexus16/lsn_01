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
  get "/admin", to: "admin#index"
  resources :questions, only: :show
  resources :reports, only: [:new, :create]
  resources :votes, only: [:create, :destroy]
end
