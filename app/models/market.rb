class Market < ApplicationRecord
	has_many :user_markets
	has_many :users,  through: :user_markets

end
