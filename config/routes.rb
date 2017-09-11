Rails.application.routes.draw do

  get 'listings/show'

  devise_for :users
  get 'classifieds/index'

  root 'pages#home'

  get 'stations/show'

  get '/patients/:id', to: 'patients#show'

  get '/about', to: 'pages#about'
  get '/contact', to: 'pages#contact'
  get '/legal', to: 'pages#legal'
  get '/pricing', to: 'pages#pricing'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
