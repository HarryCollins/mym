class UserMarket < ApplicationRecord
	belongs_to :user
	belongs_to :market

	validates_uniqueness_of :is_founder, scope: :market_id, conditions: -> { where(is_founder: 'true') }
	validates_uniqueness_of :user_id, scope: :market_id

	before_destroy :is_founder?, prepend: true
	before_destroy :has_bets?, prepend: true

	after_create_commit { UsersBroadcastJob.perform_later(self.market.id, "all_users_in_market_#{self.market.id}", "user_partial") }
	after_destroy_commit { UsersBroadcastJob.perform_later(self.market.id, "all_users_in_market_#{self.market.id}", "user_partial") }

	private

		def is_founder?
			if self.is_founder == true
				errors.add(:base, "You are the market founder")
				throw :abort
			end
		end

		def has_bets?
			if self.market.lays.any? || self.market.backs.any?
				errors.add(:base, "You have open bets against the market")
				throw :abort
			end
		end
end


