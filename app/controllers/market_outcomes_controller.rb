class MarketOutcomesController < ApplicationController

    def new
        @mo = MarketOutcome.new(market: Market.find(params[:id]))
    end

    def create
        #TODO put the below in private params.require method
        @mo = MarketOutcome.new(outcome: params[:market_outcome][:outcome], market: Market.find(params[:id]))

	    #need to modify to test for possibility of user saving and account not saving
		if @mo.save
			flash[:success] = "New outcome added successfully"
			redirect_to edit_market_path(Market.first)			
		else
		    flash[:danger] = "New outcome NOT added successfully"
      		redirect_to edit_market_path(Market.first)
    	end        
    end
    
    private
	def outcomes_params
		  params.require(:market_outcome).permit(:name, :market)
	end

end