class MarketsController::ProcessMarketResults

	def initialize(market)
		@market = market
	end

	def process
		@market.market_outcomes.each do |mo|
			save_market_outcome_results(mo)
		end
	end

	def save_market_outcome_results(mo)
		mo.hits.each do |hit|
			mo.result ? pnl = (hit.back.odds * hit.amount) - hit.amount : pnl = -(hit.back.odds * hit.amount) - hit.amount
			mo.result ? winner = hit.back.user : winner = hit.lay.user
			mo.result ? loser = hit.lay.user : loser = hit.back.user
			result = Result.new(result: mo.result, winner_id: winner.id, loser_id: loser.id, market_outcome_id: mo.id, pnl: pnl)
			result.save
		end
	end
end