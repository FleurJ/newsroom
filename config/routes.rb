Rails.application.routes.draw do

  get '/favorites', to: 'articles#favorites'
  get '/draft', to: 'articles#draft'
  get '/search', to: 'articles#search'
  delete '/delete-drafts', to: 'articles#delete_drafts'

  resources :articles do
    put :favorite, on: :member
    resources :comments
  end
  devise_for :users
  root to: 'pages#home'
  resources :users_administration
  resources :user_account, only: [:show, :edit, :update]
  resources :newsletters
  resources :tags
end
