Rails.application.routes.draw do
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	
	root 'pages#test'

	resources :users, except: [:new] do
		member do
			get 'account'
		end
	end

	get '/register' => 'users#new'

	resources :markets

	resources :markets do
		member do
		  resources :market_outcomes
		end
	end



end
