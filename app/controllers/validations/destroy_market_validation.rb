class Validations::DestroyMarketValidation

	def initialize(market)
		@market = market
		@lays = @market.lays
		@backs = @market.backs
	end

	def can_destroy?
		!@lays.any? && !@backs.any?
	end

	def add_errors
		@market.errors.add(:base, "Bets have been made against this market - it can not be deleted")
	end

end