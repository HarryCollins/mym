class OpenBetsBroadcastJob < ApplicationJob
	queue_as :default

	def perform(hit, market_id, stream, identifier_for_js, user_id)
		ActionCable.server.broadcast stream, open_bets: render_open_bets(market_id, user_id, identifier_for_js),
					new_hit: render_new_hit(hit), "#{identifier_for_js}": true
	end

	private

	def render_open_bets(market_id, user_id, identifier_for_js)
		ApplicationController.renderer.render(partial: 'markets/user_bet', collection: user_bets(user_id, market_id, identifier_for_js) )
	end

	def render_new_hit(hit)
		ApplicationController.renderer.render(partial: 'markets/user_hit', locals: { user_hit: hit } )
	end

	def user_bets(user_id, market_id, identifier_for_js)
		if identifier_for_js == "back_partial"
			User.find(user_id).backs.joins(:market_outcome).where('market_outcomes.market_id = ?', market_id).where('backs.current_amount != ?', 0)
		elsif identifier_for_js == "lay_partial"
			User.find(user_id).lays.joins(:market_outcome).where('market_outcomes.market_id = ?', market_id).where('lays.current_amount != ?', 0)
		end
	end

end