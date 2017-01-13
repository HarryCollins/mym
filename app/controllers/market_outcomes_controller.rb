class MarketOutcomesController < ApplicationController

    def new
        @mo = MarketOutcome.new(market: Market.find(params[:id]))
    end
    
    private
	def outcomes_params
		  params.require(:market_outcome).permit(:name, :market)
	end

end