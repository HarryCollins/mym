class PagesController < ApplicationController

	def home
		
	end

	def test
		@market = Market.last
	end

end
