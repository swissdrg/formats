Rails.application.routes.draw do

  root 'formats#index'

	get '/formats' => 'formats#index'
	get '/formats/new' => 'formats#new'
	post 'formats' => 'formats#create'

  get '/preview' => 'preview#index'



  devise_for :users, :skip => [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end


  #get '/users/show' => 'users#show'
  #get '/formats/users/show' => 'users#show'

  post '/uploads' => 'uploads#save'

  # This needs to be at the end of the file in order to not override any custom routes
  resources :formats
  resources :variables
  resources :uploads
  resources :users


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
