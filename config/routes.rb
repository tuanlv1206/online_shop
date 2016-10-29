Rails.application.routes.draw do
  root to: 'dashboard#home'
  get 'attachment/:id/:filename.:extension' => 'attachments#show'

  resources :countries
  resources :delivery_services do
    resources :delivery_service_prices
  end

  resources :tax_rates

  resources :product_categories do
    resources :localisations, controller: 'product_category_localisations'
  end

  resources :products do
    resources :variants
    resources :localisations, controller: 'product_localisations'
    collection do
      get :import
      post :import
    end
  end

  resources :stock_level_adjustments, only: [:index, :create]

  resources :attachments, only: :destroy

  resources :customers do
    post :search, on: :collection
    resources :addresses
  end

  resources :orders do
    collection do
      post :search
    end
    member do
      post :accept
      post :reject
      post :ship
      get :despatch_note
    end
    resources :payments, only: [:create, :destroy] do
      match :refund, on: :member, via: [:get, :post]
    end
  end

  resources :users

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'

  get 'login/reset' => 'password_resets#new'
  post 'login/reset' => 'password_resets#create'

  delete 'logout' => 'sessions#destroy'
end
