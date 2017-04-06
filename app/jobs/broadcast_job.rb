class BroadcastJob < ApplicationJob
	queue_as :default

	def perform(market_id, stream, identifier_for_js)
		ActionCable.server.broadcast stream, user: render_users(market_id),
					"#{identifier_for_js}": true
	end

	private

	def render_users(market_id)
		ApplicationController.renderer.render(partial: 'markets/user', collection: Market.find(market_id).users )
	end

end