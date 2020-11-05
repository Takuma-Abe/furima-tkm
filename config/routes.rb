Rails.application.routes.draw do
  get 'comments/create'
  get 'transactions/index'
  devise_for :users
  root 'items#index'
  resources :items do
    resources :transactions, only: [:index, :new, :create]
    resources :comments , only: [:create]
  end
end
