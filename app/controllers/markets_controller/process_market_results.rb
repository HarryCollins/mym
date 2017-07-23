class MarketsController::ProcessMarketResults

	def initialize(market)
		@market = market
	end

	def process
		#process results depending on whether fixed or spread
		if @market.market_type.id == 1 #fixed
			@market.market_outcomes.each do |mo|
				save_market_outcome_results_fixed(mo)
			end
		else #spread
			@market.market_outcomes.each do |mo|
				save_market_outcome_results_spread(mo)
			end
		end			
	end

	def save_market_outcome_results_fixed(mo)
		mo.hits.each do |hit|

			backer = hit.back.user
			layer = hit.lay.user

			if mo.result == 1 #backer wins
				backer_pnl = (hit.back.odds * hit.amount) - hit.amount
				layer_pnl = backer_pnl * -1
			else #layer wins
				layer_pnl = hit.amount
				backer_pnl = layer_pnl * -1
			end

			result = Result.new(result: mo.result, backer_id: backer.id, layer_id: layer.id, 
				market_outcome_id: mo.id, hit_id: hit.id, 
				backer_pnl: backer_pnl, layer_pnl: layer_pnl)
			result.save

		end
	end

	def save_market_outcome_results_spread(mo)
		mo.hits.each do |hit|

			backer = hit.back.user
			layer = hit.lay.user

			if mo.result < hit.odds #layer wins
				layer_pnl = (hit.odds - mo.result) * hit.amount
				backer_pnl = layer_pnl * -1
			elsif mo.result > hit.odds #backer wins
				backer_pnl = (mo.result - hit.odds) * hit.amount
				layer_pnl = backer_pnl * -1
			elsif mo.result == hit.odds #draw
				layer_pnl = 0
				backer_pnl = 0
			end

			result = Result.new(result: mo.result, backer_id: backer.id, layer_id: layer.id, 
				market_outcome_id: mo.id, hit_id: hit.id, 
				backer_pnl: backer_pnl, layer_pnl: layer_pnl)
			result.save

		end
	end

end