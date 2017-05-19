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
    validate :user_is_member_of_market, on: :create

    after_create :create_hits, :update_user_account
    after_create_commit { broadcast_mo_change_to_market_users }

    attr_accessor :hitter
    alias_method :hitter?, :hitter
    
    
    private

        def user_is_member_of_market
            if !user.user_markets.where(market: market_outcome.market).any?
                errors.add(:base, "You must be a member of the market")
            end
        end
        
        def broadcast_mo_change_to_market_users
            MarketOutcomeBroadcastJob.perform_later(market_outcome.id, "all_users_in_market_#{market_outcome.market.id}", "mo_partial")
        end
        
        def create_hits
            if hitter?
                backs = Back.by_odds(self.odds)
                amount_of_hit_left = self.original_amount
                total_amount_reached = false

			    backs.each do |back|
					if back.current_amount >= amount_of_hit_left
						back.update(current_amount: back.current_amount - amount_of_hit_left)
						hit = self.hits.build(back_id: back.id, amount: amount_of_hit_left)
						hit.save!
						total_amount_reached = true
					elsif back.current_amount < amount_of_hit_left && back.current_amount != 0
						amount_of_hit_left -= back.current_amount
						hit = self.hits.build(back_id: back.id, amount: back.current_amount)
						back.update(current_amount: 0)
						hit.save!
					end
					break if total_amount_reached == true
				end		    
            end
        end
        
        def update_user_account
            new_balance = (user.account.balance -= (self.original_amount * self.odds) - self.original_amount)
            user.account.update!(balance: new_balance) 
        end

end
