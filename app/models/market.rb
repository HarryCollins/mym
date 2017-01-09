class Market < ApplicationRecord
	has_many :user_markets
	has_many :users,  through: :user_markets
	belongs_to :market_type
	has_many :market_outcomes	

end
