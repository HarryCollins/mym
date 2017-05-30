class HitsController < ApplicationController
    
    def create
		market = Market.find(params[:id])
		@market = MarketPresenter.new(market, view_context)
		@mo = MarketOutcome.find(params[:market_outcome_id])

		pl_direction = params[:bet_direction] + "s"

		bet = @mo.send(pl_direction.to_sym).build(back_params)
			
		respond_to do |format|
			if bet.save
				format.html { redirect_to market_path(@market) }
				format.js { }
			else
				format.html { redirect_to market_path(@market) }
				format.js do
					flash[:danger] = bet.errors.full_messages.join("<br>").html_safe
					flash[:danger] = bet.user.account.errors.full_messages.join("<br>").html_safe
					render js: %(window.location.pathname='#{market_path(@market)}')					
				end
			end
		end		
    end
    
    private
    
	def back_params
		  params.permit(:odds, :original_amount).merge(user_id: current_user.id, current_amount: 0, hitter: true)
	end

	def lay_params
		  params.permit(:odds, :original_amount).merge(user_id: current_user.id, current_amount: 0, hitter: true)
	end


end
