Rails.application.routes.draw do
  root "pages#show", page: "home"

  devise_for :users, controllers: { sessions: 'users/sessions' }

  get "/pages/:page" => "pages#show"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :charges, only: [:create]
  resources :search, only: :index
  resources :domains, only: [:index, :show, :create]
  resource :stripe_form, only: :show
end
