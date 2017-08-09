class MarketsController::ProcessMarketPayments

	def initialize(market)
		@market = market
	end

	def process
		create_hash
	end

	def create_hash
		payments_hash = Hash.new
		@market.users.each do |user|
			user_pnl = m.results.where(backer: User.first).sum(:backer_pnl).to_i
			user_pnl += m.results.where(layer: User.first).sum(:layer_pnl).to_i
			payments_hash[user.firstname] = user_pnl
		end
		byebug
	end

end