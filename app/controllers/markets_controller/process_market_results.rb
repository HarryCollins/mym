class MarketsController::ProcessMarketResults

	def initialize(market)
		@market = market
	end

	def process
		@market.market_outcomes.each do |mo|
			save_market_outcome_results(mo)
			update_user_account_balances
		end
	end

	def save_market_outcome_results(mo)
		mo.hits.each do |hit|
			if mo.result
				winner = hit.back.user
				loser = hit.lay.user
				winner_returns = hit.back.odds * hit.amount
				winner_pnl = (hit.back.odds * hit.amount) - hit.amount
			else
				winner = hit.lay.user
				loser = hit.back.user
				winner_returns = hit.back.odds * hit.amount
				winner_pnl = hit.amount
			end

			result = Result.new(result: mo.result, winner_id: winner.id, loser_id: loser.id, 
				market_outcome_id: mo.id, hit_id: hit.id, 
				winner_returns: winner_returns, winner_pnl: winner_pnl)
			result.save
		end
	end

	def update_user_account_balances
		@market.results.each do |result|
			result.winner.account.balance += result.winner_returns
			result.winner.account.save
		end
	end
end