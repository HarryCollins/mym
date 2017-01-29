class UserMarket < ApplicationRecord
	belongs_to :user
	belongs_to :market

	validates_uniqueness_of :is_founder, scope: :market_id, conditions: -> { where(is_founder: 'true') }
	validates_uniqueness_of :user_id, scope: :market_id

	before_destroy :check_for_bets_and_lays

	private
		def check_for_bets_and_lays
			#not working!
			if market.market_outcomes.joins(:lays).any?
				#throw :abort
			end
		end

end
