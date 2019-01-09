class Result < ApplicationRecord
	belongs_to :market_outcome
	belongs_to :backer, class_name: 'User', foreign_key: 'backer_id'
	belongs_to :layer, class_name: 'User', foreign_key: 'layer_id'
	belongs_to :hit

	scope :by_user_backer_or_layer, -> (user) { where('backer_id = ? OR layer_id = ?', user.id, user.id) }

	validates :result, presence: true if :any_bets_matched_against_outcome

	#does this work?
	def any_bets_matched_against_outcome
		market_outcome.hits.any?
	end

	def pnl(user, result)
		if winner == user
			if result
				backer_returns - hit.amount
			else 
				hit.amount
			end
		else
			if result
				-hit.amount
			else 
				(backer_returns - hit.amount)
			end
		end
	end

end
