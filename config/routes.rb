Rails.application.routes.draw do

  get 'variables/new' => 'variables#new'
	get '/variables/newform' => 'variables#newform'

	resources :formats
	resources :variables

	root 'formats#index'

	get '/formats' => 'formats#index'

	get '/formats/new' => 'formats#new'

	post 'formats' => 'formats#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
