Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
  }

  devise_scope :user do
    get 'users/new_address_preset', to: 'users/registrations#new_address_preset'
    post 'users/create_address_preset', to: 'users/registrations#create_address_preset'
  end
  root 'items#index'
  resources :items do
    resources :transactions, only: [:index, :new, :create]
    resources :comments , only: [:create]
    collection do
      get 'search'
    end
    member do
      get :purchase_confirm
      post :purchase
    end
  end
  resources :cards, only: [:index, :new, :create, :destroy]
end
