class MarketsController < ApplicationController

	before_action :require_user, except: [:show, :index]

	def index
		@markets = Market.all
		@markets = Market.founded_by_user(current_user) if params[:founder].present?
		@markets = Market.joined_by_user(current_user) if params[:joined].present?
	end

	def show
		@market = Market.find(params[:id])
	end

	def new
		@market = Market.new
		#create blank outcomes
		1.times { @market.market_outcomes.build }
	end

	def create
		market = Market.new(market_params)
		#current_user.markets << market
		market.user_markets << UserMarket.new(user: current_user, is_founder: true)

	    if market.save(market_params)
			flash[:success] = "You have sucessfully created this market"
			redirect_to market_path(market)
	    else
	      render :edit
	    end
	end

	def edit
		@market = Market.find(params[:id])
		if @market.market_outcomes.empty?
			1.times { @market.market_outcomes.build }
		end
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
	
	def destroy
	    if Market.find(params[:id]).destroy
		    flash[:success] = "Market Deleted"
		    redirect_to markets_path	    	
	    else
	      render :edit	    	
	    end
	end

	def join
		@market = Market.find(params[:id])
		user_market = @market.user_markets.build(user: current_user)
		
		if user_market.save
			flash[:success] = "Your have successfully joined this market!"
			redirect_to market_path(@market)
		else	
			redirect_to market_path(@market)			
		end
		
	end

	private
	
	def market_params
		  params.require(:market).permit(:name, :description, :market_type_id, market_outcomes_attributes: [:id, :outcome, :_destroy])	
	end

end
