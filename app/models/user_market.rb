class UserMarket < ApplicationRecord
	belongs_to :user
	belongs_to :market

	validates_uniqueness_of :is_founder, scope: :market_id, conditions: -> { where(is_founder: 'true') }
	validates_uniqueness_of :user_id, scope: :market_id

	#before_destroy :check_for_bets_and_lays

	#private
		#TODO: fix the below  for below validation...
		def add_error_for_bets_and_lays
			if market.market_outcomes.joins(:lays).any?
				#market.market_outcomes.includes(:lays).lays.where("lays.user_id = ?", user_id).any?
				self.errors.add(:user, "You have open bets against this market")
			end
		end

end
