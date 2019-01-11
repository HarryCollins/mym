class Back < ApplicationRecord
    belongs_to :market_outcome
    belongs_to :user
    has_many :hits
    has_many :lays,  through: :hits
    
    default_scope { order(created_at: :asc) }
    scope :by_user, -> (current_user) { where(user: current_user)}
    scope :by_odds, -> (odds) { where(odds: odds)}
    scope :by_market_outcome, -> (market_outcome) { where(market_outcome: market_outcome) }
    scope :non_zero_current_amount, -> { where('current_amount != 0') }

    validates :original_amount, presence: true
    validates :current_amount, numericality: { greater_than_or_equal_to: 0 }
    validates :odds, presence: true
    validate :user_is_member_of_market, on: :create
    validate :market_is_published, on: :create

    before_save :offsetting_exposure_calc
    
    after_create :process_hits
    after_create_commit { broadcast_mo_change_to_market_users }
    
    attr_accessor :hitter
    alias_method :hitter?, :hitter

    private

        def user_is_member_of_market
            if !user.user_markets.where(market: market_outcome.market).any?
                errors.add(:base, "You must be a member of the market")
                return false
            end
        end

        def market_is_published
            if self.market_outcome.market.market_status_id != 2
                errors.add(:base, "This market is not yet published")
                return false
            end            
        end
    
        def broadcast_mo_change_to_market_users
            MarketOutcomeBroadcastJob.perform_later(market_outcome.id, "all_users_in_market_#{market_outcome.market.id}", "mo_partial")
        end

        def offsetting_exposure_calc
            if hitter?
                amount_of_opposing_exposure(array_of_user_opposite_exposure)
            end
        end

        def amount_of_opposing_exposure(array_of_backs_or_lays)
            @offsetting_exposure = (array_of_backs_or_lays.sum(:current_amount) * self.odds) || 0
        end

        def array_of_user_opposite_exposure
            @offseting_lays = Lay.by_market_outcome(self.market_outcome).by_odds(self.odds).by_user(self.user)
        end

        def process_hits
            if hitter?
                @amount_of_hit_left = self.original_amount
                @total_amount_reached = false

                user_offsetting_lays = array_of_user_opposite_exposure
                create_hits(user_offsetting_lays)

                lays = Lay.by_market_outcome(self.market_outcome).by_odds(self.odds)
                create_hits(lays)      
            end
        end

        def create_hits(bets)
            bets.each do |bet|
                if bet.current_amount >= @amount_of_hit_left && @amount_of_hit_left != 0 && bet.current_amount != 0
                    bet.update(current_amount: bet.current_amount - @amount_of_hit_left)
                    hit = self.hits.build(lay_id: bet.id, amount: @amount_of_hit_left)
                    hit.save!
                    @amount_of_hit_left = 0
                    @total_amount_reached = true
                elsif bet.current_amount < @amount_of_hit_left && bet.current_amount != 0
                    @amount_of_hit_left -= bet.current_amount
                    hit = self.hits.build(back_id: bet.id, amount: bet.current_amount)
                    bet.update(current_amount: 0)
                    hit.save!
                end
                break if @total_amount_reached == true
            end 
        end
    
end
