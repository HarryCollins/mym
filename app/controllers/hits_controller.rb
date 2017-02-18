class HitsController < ApplicationController
    
    def create
		market = Market.find(params[:id])
		@market = MarketPresenter.new(market, view_context)
		@mo = MarketOutcome.find(params[:market_outcome_id])
		if params[:bet_direction] == "back"
		    bet = @mo.backs.build(back_params)
		    lays = Lay.by_odds(params[:odds])
		    amount_of_hit_left = params[:original_amount].to_d
		    
		    total_amount_reached = false
		    
		    lays.each do |lay|
				if lay.current_amount >= amount_of_hit_left
					lay.update(current_amount: lay.current_amount - amount_of_hit_left)
					hit = bet.hits.build(lay_id: lay.id, amount: params[:original_amount])
					hit.save
					total_amount_reached = true
				elsif lay.current_amount < amount_of_hit_left && lay.current_amount != 0
					amount_of_hit_left -= lay.current_amount
					hit = bet.hits.build(lay_id: lay.id, amount: lay.current_amount)
					hit.save
					lay.update(current_amount: 0)
				end
				break if total_amount_reached == true
			end		    


		else
			bet = @mo.lays.build(lay_params)
		end
		
		
		
		respond_to do |format|
			if bet.save
				format.html { redirect_to market_path(@market) }
				#format.js { }
			else
				format.html { redirect_to market_path(@market) }	
			end
		end
    end
    
    private
    
	def back_params
		  params.permit(:odds, :original_amount).merge(user_id: current_user.id, current_amount: params[:back_hit_amount])
	end
	def lay_params
		  params.permit(:odds, :original_amount).merge(user_id: current_user.id, current_amount: params[:lay_hit_amount])
	end
	# def hit_params
	# 	  params.permit(:odds, :amount).merge(user_id: current_user.id, amount: params[:lay_hit_amount])
	# end
    
end
