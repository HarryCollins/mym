class MarketPresenter < BasePresenter
	
    def founder_name
        "#{mkfounder.firstname} #{mkfounder.secondname}"
    end

	def user_lays(user)
		user.lays.joins(:market_outcome).where('market_outcomes.market_id = ?', self)
	end

	def bet_details(bet)
		"#{bet.market_outcome.outcome} - £#{bet.amount} @ #{bet.odds}"
	end

	def user_backs(user)
		user.backs.joins(:market_outcome).where('market_outcomes.market_id = ?', self)
	end

end

