class Lay < ApplicationRecord
    belongs_to :market_outcome
    belongs_to :user
    has_many :hits
    has_many :backs,  through: :hits
    
    default_scope { order(created_at: :asc) }
    scope :by_user, -> (current_user) { where(user: current_user)}
    scope :by_odds, -> (odds) { where(odds: odds)}
    scope :non_zero_current_amount, -> { where('current_amount != 0') }

    validates :original_amount, presence: true
    validates :odds, presence: true

    after_create :update_user_account
    after_create_commit { broadcast_mo_change_to_market_users }


    private

        def broadcast_mo_change_to_market_users
            MarketOutcomeBroadcastJob.perform_later(market_outcome.id, "all_users_in_market_#{market_outcome.market.id}", "mo_partial")
        end

        def update_user_account
            new_balance = (user.account.balance -= (self.original_amount * self.odds) - self.original_amount)
            user.account.update!(balance: new_balance) 
        end

end
