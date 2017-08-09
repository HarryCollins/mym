 class Market < ApplicationRecord
	has_many :user_markets, dependent: :destroy
	has_many :users,  through: :user_markets
	has_many :messages
	belongs_to :market_type
	belongs_to :market_status
	has_many :market_outcomes, dependent: :destroy, inverse_of: :market
	has_many :backs, through: :market_outcomes
	has_many :lays, through: :market_outcomes
	has_many :results, through: :market_outcomes
	has_many :payments

	scope :not_marked_as_complete, -> { where('market_status_id != 3') }
	scope :marked_as_complete, -> { where('market_status_id = 3') }
	
	validates :market_status_id, presence: true
	validates :name, presence: true
	validates :description, presence: true
	
	before_destroy :has_backs_or_lays, prepend: true
	
	accepts_nested_attributes_for :market_outcomes, allow_destroy: true

	def self.founded_by_user(current_user)
		current_user.markets.includes(:user_markets).where('user_markets.is_founder = ?', true)
	end

	def self.joined_by_user(current_user)
		current_user.markets
	end
	
	#instance methods
	def mkfounder
		users.includes(:user_markets).where('user_markets.is_founder = ?', true).first
	end

	private

		def has_backs_or_lays
			if self.lays.any? || self.backs.any?
				errors.add(:base, "Bets have been made against this market - it can not be deleted")
				throw :abort
			end
		end

end
 