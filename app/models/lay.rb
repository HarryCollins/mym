class Lay < ApplicationRecord
    belongs_to :market_outcome
    belongs_to :user
    has_many :hits
    has_many :backs,  through: :hits
    default_scope { order(created_at: :asc) }
    scope :by_user, -> (current_user) { where(user: current_user)}
    scope :by_odds, -> (odds) { where(odds: odds)}

    validates :original_amount, presence: true
    validates :odds, presence: true


end
