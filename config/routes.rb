Rails.application.routes.draw do
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	
	root 'pages#home'

	# Serve websocket cable requests in-process
	mount ActionCable.server => '/cable'
	
	get '/test' => 'pages#test'

	resources :users, except: [:new] do
		member do
			get 'account'
		end
	end

	get '/register' => 'users#new'
	get '/login' => 'logins#new'
	

	resources :markets do
		member do
			get '/join' => 'markets#join'
			get '/leave' => 'markets#leave'
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
