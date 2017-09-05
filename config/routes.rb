Rails.application.routes.draw do
  get 'classifieds/index'

  root 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
