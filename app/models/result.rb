class Result < ApplicationRecord
	belongs_to :market_outcome
	belongs_to :backer, class_name: 'User', foreign_key: 'backer_id'
	belongs_to :layer, class_name: 'User', foreign_key: 'layer_id'
	belongs_to :hit

	scope :by_user_backer_or_layer, -> (user) { where('winner_id = ? OR loser_id = ?', user.id, user.id) }

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
