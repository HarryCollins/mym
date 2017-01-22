class MarketOutcome < ApplicationRecord
	belongs_to :market, inverse_of: :market_outcomes
    has_many :backs, dependent: :destroy
    has_many :lays, dependent: :destroy



    #instance variables
 
	def outcome_back_groups
        return self.create_back_hash_array
	end
	
	def outcome_lay_groups
        return self.create_lay_hash_array
	end

	def create_back_hash_array
	    #create empty array for all back odds groups in market outcome
	    bet_groups_hash = Hash.new
	    #loop through in odds group in market outcome
	    bet_groups = backs.group_by(&:odds)
	    bet_groups_sorted = bet_groups.sort_by{|key, values| key}.reverse
	    bet_groups_sorted.each do |odds, bet_group|
            sum = 0
            #sum all amounts within odds group
            bet_group.each do |bet|
                sum += bet.amount
            end
            #add current lay group to hash
        bet_groups_hash[odds] = sum
	    end
	    
	    return bet_groups_hash
	end
	
	def create_lay_hash_array
	    #create empty array for all back odds groups in market outcome
	    bet_groups_hash = Hash.new
	    #groups bets by odds
	    bet_groups = lays.group_by(&:odds)
	    #sort bet groups by odds
	    bet_groups_sorted = bet_groups.sort_by{|key, values| key}
	    #loop through each odds grouping
	    bet_groups_sorted.each do |odds, bet_group|
            sum = 0
            #sum all amounts within odds group
            bet_group.each do |bet|
                sum += bet.amount
            end
            #add current lay group to hash
        bet_groups_hash[odds] = sum
	    end
	    
	    return bet_groups_hash
	end
    
end
