class MarketOutcome < ApplicationRecord
	belongs_to :market, inverse_of: :market_outcomes
    has_many :backs, dependent: :destroy
    has_many :lays, dependent: :destroy
    has_many :hits, through: :lays
    has_many :results, dependent: :destroy

    #validate that an outcome has not changed, once the market is published
    validate :forbid_changing_outcome_if_market_published, on: :update
    
    def forbid_changing_outcome_if_market_published
        errors[:outcome] = "can not be changed once market is published" if self.outcome_changed? if self.market.market_status_id != 1
    end

    def all_hits_on_market_outcome_by_user(user)
        @userMarketOutcomeHitsArray = []

        backs.by_user(user).each do |back|
            back.hits.each do |hit|
                @userMarketOutcomeHitsArray << hit
            end
        end
 
        lays.by_user(user).each do |lay|
            lay.hits.each do |hit|
                @userMarketOutcomeHitsArray << hit
            end
        end

        return @userMarketOutcomeHitsArray.uniq{|hit| hit.id}
    end


    def pnl_by_user(user)
        pnl = 0
        results.by_user_backer_or_layer(user).each do |result|
            if result.winner == user && result.loser != user
                pnl += result.winner_pnl
            elsif result.loser == user && result.winner != user
                pnl -= result.winner_pnl
            end
        end
        return pnl
    end

end