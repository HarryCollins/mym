class MarketOutcomeBroadcastJob < ApplicationJob
	queue_as :default

	def perform(mo_id, stream, identifier_for_js)
		ActionCable.server.broadcast stream, mo: render_open_bets(mo_id), mo_id: mo_id,
					"#{identifier_for_js}": true
	end


	private

	def render_open_bets(mo_id)
		ApplicationController.renderer.render(partial: 'markets/outcome', locals: {outcome: MarketOutcome.find(mo_id)} )
	end

end