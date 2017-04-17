class Validations::BetValidation

	def initialize(market,  user)
		@market = market
		@user = user
		@user_market = @market.user_markets.where(user: @user)
	end

	def is_member?
		!!@user_market.any?
	end

	def add_errors
		if !@user_market.any?
			@market.errors.add(:base, "You are not a member of this market")
		end
	end

end