Rails.application.routes.draw do

  root "static_pages#home"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"
  get "contact" => "static_pages#contact"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"
  namespace :admin do
    resources :users, only: [:index, :show, :destroy]
    resources :categories
    resources :words do
      resources :word_answers, only: :index
    end
  end
  get "signup" => "users#new"
  resources :users, except: :delete
  resources :relationships, only: [:create, :destroy, :show]
  resources :categories, only: [:index, :show] do
    resources :lessons, only: :create
  end
  resources :lessons
  resources :words, only: :index do
    resources :word_answers, only: :index
  end
end
