class UserMarket < ApplicationRecord
	belongs_to :user
	belongs_to :market

	validates_uniqueness_of :is_founder, scope: :market_id, conditions: -> { where(is_founder: 'true') }
	validates_uniqueness_of :user_id, scope: :market_id

	after_create_commit { BroadcastJob.perform_later(self.market.id, "all_users_in_market_#{self.market.id}", "user_partial") }
	after_destroy_commit { BroadcastJob.perform_later(self.market.id, "all_users_in_market_#{self.market.id}", "user_partial") }

end


