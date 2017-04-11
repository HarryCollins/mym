 class Market < ApplicationRecord
	has_many :user_markets, dependent: :destroy
	has_many :users,  through: :user_markets
	has_many :messages
	belongs_to :market_type
	belongs_to :status
	has_many :market_outcomes, dependent: :destroy, inverse_of: :market
	
	accepts_nested_attributes_for :market_outcomes, allow_destroy: true

	def self.founded_by_user(current_user)
		current_user.markets.includes(:user_markets).where('user_markets.is_founder = ?', true)
	end

	def self.joined_by_user(current_user)
		current_user.markets
	end
	
	#instance methods
	def mkfounder
		users.includes(:user_markets).where('user_markets.is_founder = ?', true).first
	end

end
