Rails.application.routes.draw do

  resources :articles
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tags, only: %i[index new edit create destroy update]
  resources :users_administration
end
