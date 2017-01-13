class UserMarket < ApplicationRecord
	belongs_to :user
	belongs_to :market

	validates_uniqueness_of :is_founder, scope: :market_id

end
