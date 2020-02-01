Rails.application.routes.draw do

  resources :articles
  devise_for :users
  root to: 'pages#home'

  resources :users_administration

end
