class MarketOutcome < ApplicationRecord
	belongs_to :market, inverse_of: :market_outcomes
    has_many :backs, dependent: :destroy
    has_many :lays, dependent: :destroy
 
	def outcome_back_groups
        return self.create_back_hash_array
	end
	
	def outcome_lay_groups
        return self.create_lay_hash_array
	end

	def create_back_hash_array
	   back_groups_hash = Hash.new
	    #loop through in odds group in market outcome
	    backs.group_by(&:odds).each do |odds, back_group|
            sum = 0
            #sum all amounts within odds group
            back_group.each do |back|
                sum += back.amount
            end
            #create hash for current hash group 
            back_groups_hash[odds] = sum
	    end
	    return back_groups_hash
	end
	
	def create_lay_hash_array
	    #create empty array for all back odds groups in market outcome
	    lay_groups_hash = Hash.new
	    #loop through in odds group in market outcome
	    lays.group_by(&:odds).each do |odds, lay_group|
            sum = 0
            #sum all amounts within odds group
            lay_group.each do |lay|
                sum += lay.amount
            end
            #add current lay group to hash
            lay_groups_hash[odds] = sum
	    end
	    
	    return lay_groups_hash
	end
	
    
end
