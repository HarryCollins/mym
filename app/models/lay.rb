class Lay < ApplicationRecord
    belongs_to :market_outcome
    belongs_to :user
    has_many :backs,  through: :hits

    def self.by_market_and_user(market, current_user)
    	user_bets_hash = Hash.new
    	market.market_outcomes.each do |mo|
    		mo_bets_hash = Hash.new
    		if mo.lays
    			lays_groups = mo.lays.where(user: current_user).group_by(&:odds).sort_by{|key, values| key}
    			lays_groups.each do |odds, bet_group|
		            sum = 0
		            #sum all amounts within odds group
		            bet_group.each do |bet|
		                sum += bet.amount
		            end
		            #add current lay group to hash
		        mo_bets_hash[odds] = sum				
    			end
    		end
    		user_bets_hash[mo] = mo_bets_hash
    	end
    	return user_bets_hash
    end
end
