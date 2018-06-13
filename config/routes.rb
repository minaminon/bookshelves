Rails.application.routes.draw do
  get 'reviews/create'

  get 'reviews/destroy'

  get 'books/show'

  get 'books/new'

  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: 'toppages#index'
  
  get 'login',to: 'sessions#new'
  post 'login',to: 'sessions#create'
  delete 'logout',to: 'sessions#destroy'
  
  get 'detail/:code',to: 'books#detail',as: :detail
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :create]
  resources :books, only: [:show, :new, :index]
  resources :authorships, only: [:create, :destroy]
  
  resources :reviews,only: [:create,:destroy,:show,:update]
  
  get '*not_found' => 'application#routing_error'
  post '*not_found' => 'application#routing_error'
  
end