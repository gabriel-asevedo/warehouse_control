Rails.application.routes.draw do

  root 'materials#index'

  devise_for :users

  resources :materials
end
