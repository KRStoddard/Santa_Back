Rails.application.routes.draw do
  resources :admin, only: [:create]
  post 'admin/login', to: 'admin#login'
  get '/auto_login', to: 'admin#auto_login'
  resources :events, only: [:create, :show, :update, :destroy]
  resources :users, only: [:create]
end
