Rails.application.routes.draw do

  get 'customers/show'

  devise_for :users
  get 'classifieds/index'

  root 'pages#home'

  get 'stations/show'

  get '/about', to: 'pages#about'
  get '/contact', to: 'pages#contact'
  get '/legal', to: 'pages#legal'
  get '/pricing', to: 'pages#pricing'

  get '/account', to:'customers#show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
