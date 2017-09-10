class PagesController < ApplicationController

	before_action :require_admin_user, only: [:admin_settings]

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

end

