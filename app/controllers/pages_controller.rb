class PagesController < ApplicationController

	def home
		
	end

	def test
		@market = Market.first
	end

end
