Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :create] do
    member do
      get :likes
    end
    collection do
      get :search
    end
  end
  
  get 'reviews', to: 'reviews#index'
  resources :reviews, only: [:new, :create, :destroy]
  
  resources :likes, only: [:create, :destroy]
end
