Rails.application.routes.draw do

  get '/draft', to: 'articles#draft'
  get '/search', to: 'articles#search'
  resources :articles
  devise_for :users
  root to: 'pages#home'
  resources :users_administration
  resources :newsletters
  resources :tags
end
