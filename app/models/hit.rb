class Hit < ApplicationRecord
    belongs_to :back
    belongs_to :lay

	scope :by_user, -> (current_user) { joins(:back).where('backs.user_id = ?', current_user)}

	after_create_commit { broadcast_to_hit_back_and_lay_users }


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
