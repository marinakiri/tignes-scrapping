Rails.application.routes.draw do
  get 'stations/show'

  devise_for :users
  get 'classifieds/index'

  root 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
