class MarketsController < ApplicationController

	def index
		@markets = Market.all
	end

	def show
		@market = Market.find(params[:id])
	end

	def new
		@market = Market.new
		#scope the below (although should never be more than 2 results)
		@marketTypes = MarketType.all
	end

	def create
		fff.fff
		@market = Market.new(market_params)
	end

	def edit
		@market = Market.find(params[:id])
		@marketTypes = MarketType.all
	end
	
	def update
		@market = Market.find(params[:id])
	    if @market.update(market_params)
	      flash[:success] = "You have sucessfully updated this market"  
	      redirect_to market_path(@market)
	    else
	      render :edit
	    end
	end
	
	private
	
	def market_params
		  params.require(:market).permit(:name, :description, :market_type_id)	
	end

end
