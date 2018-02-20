# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#show', page: 'home'

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  get '/pages/:page' => 'pages#show'
  post '/pages/create' => 'pages#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :charges, only: %i[create new]
  resources :search, only: %i[index new]
  resources :domains, only: %i[index show create update] do
    with_options module: :domains do
      resource :unlock, only: :update
      resource :nameservers, only: :update
      resource :code, only: :show
      resources :records, only: %i[create update destroy]
    end
  end
  resources :transfers, only: :create
  resources :agreements, only: [:index]
  resources :notifications, only: %i[index destroy]
  resource :details, only: [:update]
  resource :carts, only: [:show]
  resources :items, only: %i[create update destroy]
end
