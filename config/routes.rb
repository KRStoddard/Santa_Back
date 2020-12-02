Rails.application.routes.draw do
  resources :admin, only: [:create, :show]
  post 'admin/login', to: 'admin#login'
  get '/auto_login', to: 'admin#auto_login'
  resources :events, only: [:create, :show]
end
