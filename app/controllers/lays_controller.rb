class LaysController < ApplicationController

	def create
		@market = Market.find(params[:id])
		@mo = MarketOutcome.find(params[:market_outcome_id])
		user = current_user
		lay = @mo.lays.build(odds: 4,  amount: 7, user: user)
		respond_to do |format|
			if lay.save
				#format.html { redirect_to market_path(@market) }
				format.js { }
			else	
				#format.html { redirect_to market_path(@market) }	
			end
		end

	end

end
