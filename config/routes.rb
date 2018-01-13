Rails.application.routes.draw do
  root "pages#show", page: "home"

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  get "/pages/:page" => "pages#show"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :charges, only: [:create]
  resources :search, only: :index
  resources :domains, only: [:index, :show, :create, :update] do
    with_options module: :domains do
      resource :unlock, only: :update
      resource :nameservers, only: :update
      resource :code, only: :show
      resources :records, only: :create
    end
  end
  resources :transfers, only: :create
  resources :agreements, only: [:index]
  resources :notifications, only: [:index, :destroy]
  resource :details, only: [:update]
  resource :carts, only: [:show]
  resources :items, only: [:create, :update, :destroy]
end
