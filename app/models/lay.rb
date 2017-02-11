class Lay < ApplicationRecord
    belongs_to :market_outcome
    belongs_to :user
    has_many :backs,  through: :hits
    scope :by_user, -> (current_user) { where(user: current_user)}

    validates :amount, presence: true
    validates :odds, presence: true

end
