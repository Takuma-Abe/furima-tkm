Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  resources :items do
    resources :transactions, only: [:index, :new, :create]
    resources :comments , only: [:create]
  end
  resources :cards, only: [:index, :new, :create, :destrory]
end
