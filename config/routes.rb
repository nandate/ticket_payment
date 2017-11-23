Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root to: "visitors#index"
  devise_for :users
  resources :events
  resource :shopping_cart
  resources :payments
  resources :users
  resources :plans
  resources :subscriptions

  post "stripe/webhook", to: "stripe_webhook#action"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
