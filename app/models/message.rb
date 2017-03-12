class Message < ApplicationRecord
    belongs_to :user
    belongs_to :market
    
end
