Rails.application.routes.draw do

  get 'customers/show'

  devise_for :users
  resources :classifieds
  get '/search', to: 'classifieds#search'
  
  root 'classifieds#search'

  get 'stations/show'

  get '/about', to: 'pages#about'
  get '/contact', to: 'pages#contact'
  get '/legal', to: 'pages#legal'
  get '/pricing', to: 'pages#pricing'

  get '/dashboard', to:'users#dashboard'

  mount Sidekiq::Web => ‘/sidekiq’

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
