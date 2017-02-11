class LaysController < ApplicationController

	def create
		market = Market.find(params[:id])
		@market = MarketPresenter.new(market, view_context)
		@mo = MarketOutcome.find(params[:market_outcome_id])
		lay = @mo.lays.build(lay_params)
		respond_to do |format|
			if lay.save
				format.html { redirect_to market_path(@market) }
				format.js { }
			else
				format.html { redirect_to market_path(@market) }	
			end
		end

	end

	private
	
	def lay_params
		  params.permit(:odds, :amount).merge(user_id: current_user.id)
	end

end