class Validations::BetValidation

	def initialize(market, user, amount, odds, lay_or_back)
		@market = market
		@user = user
		@user_market = @market.user_markets.where(user: @user)
		@lay_or_back = lay_or_back
		@amount = amount.to_i
		@odds = odds.to_i

		if lay_or_back == :back
			@liability = @amount
		else
			@liability = (@amount * @odds) - @amount
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

	private
		def is_member?
			!!@user_market.any?
		end
	
		def enough_account_balance?
			@user.account.balance >= @liability
		end

end