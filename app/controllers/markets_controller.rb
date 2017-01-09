class MarketsController < ApplicationController

	def index
		@markets = Market.all
	end

	def show
		@markets = Market.find(params[:id])
	end

	def new
		@market = Market.new
	end

end
