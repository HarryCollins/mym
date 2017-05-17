class Validations::BetValidation

	def initialize(market, user, amount = nil, odds = nil, lay_or_back = nil)
		@market = market
		@user = user
		@user_market = @market.user_markets.where(user: @user)
		@lay_or_back = lay_or_back
		@amount = amount.to_f
		@odds = odds.to_f

		if lay_or_back == :back
			@liability = @amount
		else
			@liability = ((@amount * @odds) - @amount).round(2)
		end
	end

	def can_bet?
		!!(enough_account_balance? && is_member?)
	end

	def add_errors
		if !is_member?
			@market.errors.add(:base, "You are not a member of this market")
		end
		
		if !enough_account_balance?
			@market.errors.add(:base, "You do not have suffient funds to cover this bet - liability is £#{@liability}")
		end
	end

	def is_member?
		!!@user_market.any?
	end

	private
		def enough_account_balance?
			@user.account.balance >= @liability
		end

end