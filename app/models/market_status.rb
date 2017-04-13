class MarketStatus < ApplicationRecord
	has_many :markets
	validates :market_status, presence: true
end
