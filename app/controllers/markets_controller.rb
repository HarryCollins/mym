class MarketsController < ApplicationController

	def index
		@markets = Market.all
	end

	def show
		@market = Market.find(params[:id])
	end

	def new
		@market = Market.new
	end

	def edit
		@market = Market.find(params[:id])
	end

end
