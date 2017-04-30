class PagesController < ApplicationController

	def home
		
	end

	def test

		mo = MarketOutcome.find(127)

		@test = mo.all_hits_on_market_outcome_by_user(current_user)

	end

end
