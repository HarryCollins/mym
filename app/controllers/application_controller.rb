class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	#the methods must be declared as helper methods in order to be available in the views
	helper_method :current_user, :logged_in?, :admin_user?

	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def logged_in?
		!!current_user
	end

	def admin_user?
		!!current_user && @current_user.admin?
	end	

	def require_user
		if not logged_in?
		  flash[:danger] = "You need to be logged in to complete that action"
			if request.xhr?
				render js: "window.location = '#{root_path}'"
			else
				redirect_to root_path
			end
		end
	end

end
