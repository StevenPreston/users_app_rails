Rails.application.routes.draw do
  root 'sessions#new'
  
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]

  delete '/logout', to: 'sessions#destroy', as: 'logout'
end
