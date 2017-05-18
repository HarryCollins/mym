class HitsController::CreateHitsHash

	def initialize(bet)
		@bet = bet
		if @bet.is_a?(Back)
			@opposing_direction = "Lay"
			@opp_dir_low_pl = :lays
		else
			@opposing_direction = "Back"
			@opp_dir_low_pl = :backs
		end
	end

	def return_bet_array

		opposing_bets = @opposing_direction.constantize.by_odds(@bet.odds)
		amount_of_hit_left = @bet.original_amount.to_d
		total_amount_reached = false
		bets_array = Array.new
		bets_array << @bet

		opposing_bets.each do |op_bet|
			if op_bet.current_amount >= amount_of_hit_left
				total_amount_reached = true
				op_bet_to_save = op_bet.assign_attributes(current_amount: op_bet.current_amount - amount_of_hit_left)
				if @opposing_direction = "Back"
					hit = op_bet.hits.build(back_id: op_bet.id, amount: amount_of_hit_left)
				else
					hit = op_bet.hits.build(lay_id: op_bet.id, amount: amount_of_hit_left)
				end
				bets_array << op_bet_to_save
				bets_array << hit
			elsif op_bet.current_amount < amount_of_hit_left && op_bet.current_amount != 0
				if @opposing_direction = "Back"
					hit = op_bet.hits.build(back_id: op_bet.id, amount: op_bet.current_amount)
				else
					hit = op_bet.hits.build(lay_id: op_bet.id, amount: op_bet.current_amount)
				end
				op_bet_to_save = assign_attributes.update(current_amount: 0)
				amount_of_hit_left -= op_bet.current_amount
				bets_array << op_bet_to_save
				bets_array << hit
			end
			break if total_amount_reached == true
		end

		return bets_array

	end

end