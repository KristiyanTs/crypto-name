Rails.application.routes.draw do
  root "pages#show", page: "home"
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  get "/pages/:page" => "pages#show"
  resources :search, only: :index
end
