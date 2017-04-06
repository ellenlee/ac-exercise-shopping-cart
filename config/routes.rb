Rails.application.routes.draw do
  devise_for :users

  root "products#index"
  resources :products, only: [:index, :show] do
    post :add_to_cart, on: :member
  end
  resource :cart
  resources :orders

  namespace :admin do
    root 'products#index'
    resources :products
  end
end
