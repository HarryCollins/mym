class Back < ApplicationRecord
    belongs_to :market_outcome
    belongs_to :user
    has_many :lays,  through: :hits
    scope :by_user, -> (current_user) { where(user: current_user)}

    validates :original_amount, presence: true
    validates :odds, presence: true
    
end
