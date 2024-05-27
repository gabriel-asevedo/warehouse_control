Rails.application.routes.draw do
  get 'logs/index'
  get 'logs/show'

  root 'materials#index'

  devise_for :users

  resources :materials do
    member do
      post 'add'
      post 'remove'
    end
  end

  resources :logs, only: [:index, :show]

end
