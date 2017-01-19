class Lay < ApplicationRecord
    belongs_to :market_outcome
    belongs_to :user
    has_many :backs,  through: :hits
end
