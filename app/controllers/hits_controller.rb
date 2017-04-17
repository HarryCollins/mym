class HitsController < ApplicationController
    
    def create
		market = Market.find(params[:id])
		@market = MarketPresenter.new(market, view_context)
		@mo = MarketOutcome.find(params[:market_outcome_id])

		can_bet_validation = Validations::BetValidation.new(@market, current_user)
		
		if can_bet_validation.is_member?
		
			if params[:bet_direction] == "back"
			    bet = @mo.backs.build(back_params)
			    lays = Lay.by_odds(params[:odds])
			    amount_of_hit_left = params[:original_amount].to_d
			    
			    total_amount_reached = false
			    
			    lays.each do |lay|
					if lay.current_amount >= amount_of_hit_left
						lay.update(current_amount: lay.current_amount - amount_of_hit_left)
						hit = bet.hits.build(lay_id: lay.id, amount: amount_of_hit_left)
						hit.save
						total_amount_reached = true
					elsif lay.current_amount < amount_of_hit_left && lay.current_amount != 0
						amount_of_hit_left -= lay.current_amount
						hit = bet.hits.build(lay_id: lay.id, amount: lay.current_amount)
						lay.update(current_amount: 0)
						hit.save
					end
					break if total_amount_reached == true
				end		    
	
			else
				bet = @mo.lays.build(lay_params)
			    backs = Back.by_odds(params[:odds])
			    amount_of_hit_left = params[:original_amount].to_d
			    
			    total_amount_reached = false
			    
			    backs.each do |back|
					if back.current_amount >= amount_of_hit_left
						back.update(current_amount: back.current_amount - amount_of_hit_left)
						hit = bet.hits.build(back_id: back.id, amount: amount_of_hit_left)
						hit.save
						total_amount_reached = true
					elsif back.current_amount < amount_of_hit_left && back.current_amount != 0
						amount_of_hit_left -= back.current_amount
						hit = bet.hits.build(back_id: back.id, amount: back.current_amount)
						back.update(current_amount: 0)
						hit.save
					end
					break if total_amount_reached == true
				end	
			end
			
			respond_to do |format|
				if bet.save
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
    
	def back_params
		  params.permit(:odds, :original_amount).merge(user_id: current_user.id, current_amount: 0)
	end

	def lay_params
		  params.permit(:odds, :original_amount).merge(user_id: current_user.id, current_amount: 0)
	end


end
