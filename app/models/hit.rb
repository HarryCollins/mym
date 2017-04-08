class Hit < ApplicationRecord
    belongs_to :back
    belongs_to :lay
    

	after_create_commit { broadcast_to_hit_back_and_lay_users }

	def self.hit_lays_by_user_and_market_outcome(user, market_outcome)
		Hits.all
	end

	def self.test(odds, mo)
		joins(lay: :market_outcome).where('lays.odds = ?', odds).where('market_outcomes.id = ?', mo)
	end

	def self.test2
		joins(lay: :market_outcome).group('lays.odds')
	end

	private

	def broadcast_to_hit_back_and_lay_users
		broadcast_to_hit_back_user
		broadcast_to_hit_lay_user
	end

	def broadcast_to_hit_back_user
		OpenBetsBroadcastJob.perform_later(self, back.market_outcome.market.id, "specific_user_#{back.user.id}_in_market_#{back.market_outcome.market.id}", "back_partial", back.user.id)
	end

	def broadcast_to_hit_lay_user
		OpenBetsBroadcastJob.perform_later(self, lay.market_outcome.market.id, "specific_user_#{lay.user.id}_in_market_#{lay.market_outcome.market.id}", "lay_partial", lay.user.id)
	end

end
