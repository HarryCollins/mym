class Message < ApplicationRecord
    belongs_to :user
    belongs_to :market
    
    validates :user, presence: true
    validates :market, presence: true
    validates :message_text, length: { minimum: 1 }
end
