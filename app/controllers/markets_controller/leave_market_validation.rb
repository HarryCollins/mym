class MarketsController::LeaveMarketValidation


	def initialize(market,  user)
		@market = market
		@user = user
		@lays = @user.lays.joins(:market_outcome).where('market_outcomes.market_id = ?', @market)
		@backs = @user.lays.joins(:market_outcome).where('market_outcomes.market_id = ?', @market)
	end

	def can_leave?
		if @lays.any? || @backs.any? || @market.mkfounder === @user
			false
		else
			true
		end
	end

	def add_errors
		if @lays.any? || @backs.any?
			@market.errors.add(:base, "You have open bets on this market")
		end
		if @market.mkfounder === @user
			@market.errors.add(:base, "You are the market founder")
		end
	end

end