class MarketsController::ProcessMarketResults

	def initialize(market)
		@market = market
		@results_array = []
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
		return @results_array	
	end

	def save_market_outcome_results_fixed(mo)
		mo.hits.each do |hit|

			backer = hit.back.user
			layer = hit.lay.user

			if mo.result == 1 #backer wins
				backer_pnl = (hit.back.odds * hit.amount) - hit.amount
				layer_pnl = backer_pnl * -1
			elsif mo.result == 0
				layer_pnl = hit.amount
				backer_pnl = layer_pnl * -1
			end

			result = Result.new(result: mo.result, backer_id: backer.id, layer_id: layer.id, 
				market_outcome_id: mo.id, hit_id: hit.id, 
				backer_pnl: backer_pnl, layer_pnl: layer_pnl)

			@results_array << result

		end
		return @results_array
	end

	def save_market_outcome_results_spread(mo)
		mo.hits.each do |hit|

			backer = hit.back.user
			layer = hit.lay.user
			
			if mo.result.nil? #no result entered, not valid (dealt with in market ourcome model)
				layer_pnl = 0
				backer_pnl = 0
			elsif mo.result < hit.back.odds #layer wins
				layer_pnl = (hit.back.odds - mo.result) * hit.amount
				backer_pnl = layer_pnl * -1
			elsif mo.result > hit.back.odds #backer wins
				backer_pnl = (mo.result - hit.back.odds) * hit.amount
				layer_pnl = backer_pnl * -1
			elsif mo.result == hit.back.odds #draw
				layer_pnl = 0
				backer_pnl = 0
			end

			result = Result.new(result: mo.result, backer_id: backer.id, layer_id: layer.id, 
				market_outcome_id: mo.id, hit_id: hit.id, 
				backer_pnl: backer_pnl, layer_pnl: layer_pnl)

			@results_array << result

		end
		return @results_array
	end

end