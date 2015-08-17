Rails.application.routes.draw do
  root 	'home#index'

  get 	'/chat'									=> 'chatroom#index'

  post  'users/login'           => 'sessions#login'
  get   'users/logout'          => 'sessions#logout'

  get   'users/signup'          => 'users#signup'
  post  'users/signup'          => 'users#create'
end
