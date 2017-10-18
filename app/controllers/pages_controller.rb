class PagesController < ApplicationController

	before_action :require_admin_user, only: [:admin_settings]
	before_action :require_not_logged_in, only: [:home]

	def home
		
	end

	def about

	end

	def admin_settings

	end

	private

	def require_admin_user
		redirect_to root_path if !admin_user?
	end

	def require_not_logged_in
		redirect_to user_path(current_user) if current_user
	end

end

