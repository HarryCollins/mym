class HitsController < ApplicationController
    
    def create
		market = Market.find(params[:id])
		@market = MarketPresenter.new(market, view_context)
		@mo = MarketOutcome.find(params[:market_outcome_id])
		if params[:market_outcome_id] == :back
		    lay = @mo.lays.build(lay_params)
		end
		respond_to do |format|
			if lay.save
				format.html { redirect_to market_path(@market) }
				format.js { }
			else
				format.html { redirect_to market_path(@market) }	
			end
		end
    end
    
end
