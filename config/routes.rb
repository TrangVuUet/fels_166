Rails.application.routes.draw do
  root "static_pages#home"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"
  get "contact" => "static_pages#contact"
  namespace :admin do
    resources :categories, only: [:index, :new, :create]
  end
  get "signup" => "users#new"
  resources :users, only: [:new, :create, :show]
end
