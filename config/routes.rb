Rails.application.routes.draw do
  root "pages#show", page: "home"

  devise_for :users, controllers: { sessions: 'users/sessions' }

  get "/pages/:page" => "pages#show"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :charges, only: [:create]
  resources :search, only: :index
  resources :domains, only: [:new, :index, :show, :create, :update]
  resources :agreements, only: [:index]
  resources :notifications, only: [:index, :destroy]
  resource :details, only: [:update]
end
