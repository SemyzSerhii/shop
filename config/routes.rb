Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get 'page/:page' => 'pages#show', as: 'page'

  resources :users do
    member do
      get 'reviews'
    end
  end

  resources :orders
  post 'orders/:id', to: 'orders#destroy'
  resources :carts
  resources :line_items
  post 'line_items/:id/minus', to: 'line_items#minus_quantity', as: 'line_item_minus'

  resources :products, only: [:index, :show] do
    resources :reviews
  end

  get ':category/products' => 'products#index', as: 'category_products'

  resources :sessions, only: [:new, :create]
  resources :password_resets
  delete 'logout' => 'sessions#destroy'

  root 'products#index'

  match 'shop_admin/*path' => redirect('/shop_admin'), via: [:get, :post]
  match '*path' => redirect('/'), via: [:get, :post]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
