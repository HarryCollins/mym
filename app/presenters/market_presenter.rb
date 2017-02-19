class MarketPresenter < BasePresenter
	
    def founder_name
        "#{mkfounder.firstname} #{mkfounder.secondname}"
    end

	def user_lays(user, without_zeros = false)
		if without_zeros == false
			user.lays.joins(:market_outcome).where('market_outcomes.market_id = ?', self)
		else
			user.lays.joins(:market_outcome).where('market_outcomes.market_id = ?', self).where('lays.current_amount != ?', 0)
		end
	end

	def bet_details(bet)
		"#{bet.market_outcome.outcome} - £#{bet.amount} @ #{bet.odds}"
	end

	def user_backs(user, without_zeros = false)
		if without_zeros == false
			user.backs.joins(:market_outcome).where('market_outcomes.market_id = ?', self)
		else
			user.backs.joins(:market_outcome).where('market_outcomes.market_id = ?', self).where('backs.current_amount != ?', 0)
		end
	end

end

