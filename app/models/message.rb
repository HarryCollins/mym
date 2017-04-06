class Message < ApplicationRecord
    belongs_to :user
    belongs_to :market
    
    validates :user, presence: true
    validates :market, presence: true
    validates :message_text, length: { minimum: 1 }


	# Returns a list of users @mentioned in message content.
	def mentions
		message_text.scan(/@(\S+)/).flatten.map do |firstname|
			User.find_by(firstname: firstname)
		end.compact
	end
	
end
