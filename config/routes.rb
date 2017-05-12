Rails.application.routes.draw do
  devise_for :users

  root "products#index"
  resources :products, only: [:index, :show] do
    post :add_to_cart, on: :member
  end
  resource :cart
  resources :orders do
    post :checkout_pay2go, on: :member
  end

  namespace :admin do
    root 'orders#index'
    resources :products
    resources :orders
  end
end
