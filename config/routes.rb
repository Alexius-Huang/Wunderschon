Rails.application.routes.draw do
  root to: 'rabbit#index'
  get 'rabbit/index'

  resources :categories, only: [:show] do
    collection do
      get :main
    end

    resources :products, only: [:show]
  end

  resources :orders, path_names: { new: 'checkout' }

  namespace :backend do
    resources :categories, only: [:new, :edit, :update, :destroy]
    resources :orders,     only: [:index, :show, :edit, :update, :destroy]
    resources :products,   only: [:new, :edit, :update, :destroy]
    resources :users
  end
end
