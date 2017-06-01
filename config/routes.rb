Rails.application.routes.draw do
  root to: 'rabbit#index'
  get 'rabbit/index'
end
