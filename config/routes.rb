Rails.application.routes.draw do
  devise_for :users

  root "products#index"

  resources :products, only: [:index, :show] do
    post :add_to_cart, on: :member
  end

  resource :cart
  resources :orders do
    post :checkout, on: :member
  end


  post 'pay2go/return'
  post 'pay2go/notify'

  namespace :admin do
    root 'orders#index'
    resources :products
    resources :orders
  end

  scope path: '/api/v1/', module: 'api_v1', as: 'v1', defaults: { format: :json } do

    post "/login" => "auth#login"
    post "/logout" => "auth#logout"

    resources :products, only: [:index, :show]
  end

end
