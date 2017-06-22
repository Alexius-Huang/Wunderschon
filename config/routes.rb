Rails.application.routes.draw do
  devise_for :users
  root to: 'rabbit#index'
  get 'rabbit/index'

  resources :categories, only: [:show] do
    collection do
      get :main
    end

    resources :products, only: [:show]
  end

  resources :orders, path_names: { new: 'checkout' }

  namespace :backend, path: :dashboard do
    resources :categories
    resources :orders, only: [:index, :show, :edit, :update, :destroy]
    resources :products, path_names: { new: 'new/(:category_id)' }
    resources :users
    get 'main'
  end

  namespace :ajax do
    get  'cart/info' => 'cart#info', as: :cart_info
    post 'cart/add_product' => 'cart#add_product', as: :add_product_to_cart
    post 'cart/delete_product' => 'cart#delete_product', as: :delete_product_from_cart
  end
end
