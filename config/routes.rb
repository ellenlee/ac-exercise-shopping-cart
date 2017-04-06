Rails.application.routes.draw do
  devise_for :users

  root "products#index"
  resources :products, only: [:index, :show]
  resource :cart

  namespace :admin do
    root 'products#index'
    resources :products
  end
end
