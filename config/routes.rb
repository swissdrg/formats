Rails.application.routes.draw do

  root 'formats#index'

	get '/formats' => 'formats#index'
	get '/formats/new' => 'formats#new'
	post 'formats' => 'formats#create'

  get '/variables/new' => 'variables#new'
  get '/variables/show' => 'variables#show'
  get '/variables/form' => 'variables#form'

  get '/preview' => 'preview#index'

  get '/users/show' => 'users#show'

  # This needs to be at the end of the file in order to not override any custom routes
  resources :formats
  resources :variables
  resources :uploads
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
