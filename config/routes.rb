Rails.application.routes.draw do

	resources :formats

	root 'formats#index'

	get '/formats' => 'formats#index'

	get '/formats/new' => 'formats#new'

	post 'formats' => 'formats#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
