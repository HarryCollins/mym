class PagesController < ApplicationController

	def home
		
	end

	def test
      ziz = cookies.encrypted[Rails.application.config.session_options[:key]]
      @user = User.find_by(id: ziz["user_id"])
	end

end
