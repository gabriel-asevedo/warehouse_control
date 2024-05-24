Rails.application.routes.draw do
  get 'logs/index'
  get 'logs/show'

  root 'materials#index'

  devise_for :users

  resources :materials
end
