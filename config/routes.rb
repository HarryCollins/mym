Rails.application.routes.draw do
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	
	root 'pages#home'

	# Serve websocket cable requests in-process
	mount ActionCable.server => '/cable'
	
	get '/test' => 'pages#test'
	get '/register' => 'users#new'
	get '/login' => 'logins#new'
	
	resources :users, except: [:new]

	resources :markets do
		member do
			get '/join' => 'markets#join'
			get '/leave' => 'markets#leave'
			get '/results_form' => 'markets#results_form'
			post '/complete' => 'markets#complete'
			get '/results' => 'markets#results'
			resources :messages
			resources :market_outcomes do
				post '/new_back' => 'backs#create'
				post '/new_lay' => 'lays#create'
				post '/new_hit' => 'hits#create'
			end
		end
	end

	get '/login' => 'logins#new'
	post '/login' => 'logins#create'
	get '/logout' => 'logins#destroy'

end
