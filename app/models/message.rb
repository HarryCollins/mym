class Message < ApplicationRecord
    belongs_to :user
    belongs_to :market
    
    validates :user, presence: true
    validates :market, presence: true
    validates :message_text, length: { minimum: 1 }

    validate :user_is_member_of_market, on: :create

	# Returns a list of users @mentioned in message content.
	def mentions
		message_text.scan(/@(\S+)/).flatten.map do |username|
			User.find_by(username: username)
		end.compact
	end
	
	private
	
    	def user_is_member_of_market
            if !user.user_markets.where(market: market).any?
                    errors.add(:base, "You must be a member of the market")
            end
        end
	
end
