class LaysController < ApplicationController

	def create
		market = Market.find(params[:id])
		@market = MarketPresenter.new(market, view_context)
		@mo = MarketOutcome.find(params[:market_outcome_id])

		can_bet_validation = Validations::BetValidation.new(@market, current_user, params[:original_amount], params[:odds], :lay)
		
		if can_bet_validation.can_bet?

			lay = @mo.lays.build(lay_params)
			respond_to do |format|
				if lay.save
					format.html { redirect_to market_path(@market) }
					format.js { }
				else
					format.html { redirect_to market_path(@market) }	
				end
			end

		else

			can_bet_validation.add_errors
			flash[:danger] = @market.errors.full_messages.join("<br>").html_safe
			render js: %(window.location.pathname='#{market_path(@market)}')

		end

	end

	private
	
	def lay_params
		  params.permit(:odds, :original_amount).merge(user_id: current_user.id, current_amount: params[:original_amount])
	end

end