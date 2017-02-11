class BacksController < ApplicationController

	def create
		@market = Market.find(params[:id])
		@mo = MarketOutcome.find(params[:market_outcome_id])
		user = current_user
		back = @mo.backs.build(odds: 4,  amount: 7, user: user)
		respond_to do |format|
			if back.save
				format.js { }
			else

			end
		end

	end

end
