class Market < ApplicationRecord
	has_many :user_markets, dependent: :destroy
	has_many :users,  through: :user_markets
	belongs_to :market_type
	has_many :market_outcomes, dependent: :destroy, inverse_of: :market

	accepts_nested_attributes_for :market_outcomes, allow_destroy: true

	#instance methods
	def mkfounder
		users.includes(:user_markets).where('user_markets.is_founder = ?', true).first
	end

end
