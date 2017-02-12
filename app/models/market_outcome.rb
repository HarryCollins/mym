class MarketOutcome < ApplicationRecord
	belongs_to :market, inverse_of: :market_outcomes
    has_many :backs, dependent: :destroy
    has_many :lays, dependent: :destroy


end