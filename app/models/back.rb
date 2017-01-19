class Back < ApplicationRecord
    belongs_to :market_outcome
    belongs_to :user
    has_many :lays,  through: :hits
end
