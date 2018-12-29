Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :users do
    member do
      get 'reviews'
    end
  end

  resources :products do
    resources :reviews
  end

  resources :sessions, only: [:new, :create]
  resources :password_resets
  delete 'logout' => 'sessions#destroy'

  root 'products#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
