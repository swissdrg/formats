Rails.application.routes.draw do

	resources :formats

	root 'formats#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
