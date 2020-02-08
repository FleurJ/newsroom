Rails.application.routes.draw do

  resources :articles
  get 'search', to: 'articles#search'
  devise_for :users
  root to: 'pages#home'

  resources :users_administration

  resources :tags
end
