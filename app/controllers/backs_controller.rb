class BacksController < ApplicationController

	before_action :require_user

	def create
		market = Market.find(params[:id])
		@market = MarketPresenter.new(market, view_context)
		@mo = MarketOutcome.find(params[:market_outcome_id])
		
		back = @mo.backs.build(back_params)
	
		respond_to do |format|
			if back.save
				format.html { redirect_to market_path(@market) }
				format.js { }
			else
				format.html { redirect_to market_path(@market) }
				format.js do
					flash[:danger] = back.errors.full_messages.join("<br>").html_safe
					render js: %(window.location.pathname='#{market_path(@market)}')
				end
			end
		end

	end

	private

		#TODO: add require to user_id - ie user needs to be logged in to try and back/lay	
		def back_params
			  params.permit(:odds, :original_amount).merge(user_id: current_user.id, current_amount: params[:original_amount], hitter: false)
		end

end
