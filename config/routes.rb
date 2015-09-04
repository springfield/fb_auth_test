Rails.application.routes.draw do
  root 'main#index'

  get 'login', to: 'auth#login'
  get 'logout', to: 'auth#logout'
end
