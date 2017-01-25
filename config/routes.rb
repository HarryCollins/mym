Rails.application.routes.draw do
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	
	root 'pages#home'

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
			resources :market_outcomes do
				resources :lays
				resources :hits
			end
		end
	end

	get '/login' => 'logins#new'
	post '/login' => 'logins#create'
	get '/logout' => 'logins#destroy'

end
