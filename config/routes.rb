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

  namespace :backend, path: :dashboard do
    resources :categories
    resources :orders, only: [:index, :show, :edit, :update, :destroy]
    resources :products, path_names: { new: 'new/(:category_id)' }
    resources :users
    get 'main'
  end
end
