class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  #the methods must be declared as helper methods in order to be available in the views
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    !!current_user
  end
  
end
