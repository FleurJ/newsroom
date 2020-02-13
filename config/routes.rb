Rails.application.routes.draw do

  get '/draft', to: 'articles#draft'
  resources :articles
  devise_for :users
  root to: 'pages#home'
  resources :users_administration

  resources :tags
end
