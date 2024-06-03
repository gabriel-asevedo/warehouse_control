Rails.application.routes.draw do

  root 'materials#index'

  devise_for :users, controllers: { registrations: 'registrations' }

  resources :materials do
    member do
      post 'add'
      post 'remove'
    end
  end

end
