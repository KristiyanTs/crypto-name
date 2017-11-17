Rails.application.routes.draw do
	root to: 'user#new'
  devise_for :users, controllers: {
        sessions: 'users/sessions'
  }

end
