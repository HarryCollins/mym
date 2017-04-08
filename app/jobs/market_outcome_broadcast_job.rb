class MarketOutcomeBroadcastJob < ApplicationJob
	queue_as :default

	def perform(market_id, mo_id, stream, identifier_for_js)
		ActionCable.server.broadcast stream, mo: render_open_bets(market_id, mo_id, identifier_for_js),
					"#{identifier_for_js}": true
	end


	private

	def render_open_bets(market_id, user_id, identifier_for_js)
		ApplicationController.renderer.render(partial: 'markets/user_bet', collection: user_open_bets(user_id, market_id, identifier_for_js) )
	end

end