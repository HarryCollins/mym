class MarketOutcome < ApplicationRecord
	belongs_to :market, inverse_of: :market_outcomes
    has_many :backs, dependent: :destroy
    has_many :lays, dependent: :destroy
    has_many :hits, through: :backs
    has_many :hits, through: :lays

    #validate that an outcome has not changed, once the market is published
    validate :forbid_changing_outcome_if_market_published, on: :update
    
    def forbid_changing_outcome_if_market_published
        errors[:outcome] = "can not be changed once market is published" if self.outcome_changed? if self.market.market_status_id != 1
    end

end