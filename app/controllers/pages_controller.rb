class PagesController < ApplicationController

	def home
		
	end

	def test
		@market = Market.new
		#scope the below (although should never be more than 2 results)
		@marketTypes = MarketType.all
	end

end
