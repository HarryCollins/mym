class MarketOutcome < ApplicationRecord
	belongs_to :market, inverse_of: :market_outcomes
end
