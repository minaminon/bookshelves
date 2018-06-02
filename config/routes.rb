Rails.application.routes.draw do
  

  get 'toppages/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: 'toppages#index'
  
  get 'signup', to: 'users#new'
  resources :users, only:[:index, :show, :create]
  
end
