class Account < ApplicationRecord
	belongs_to :user
	validates :balance, presence: true
	validates :user, presence: true, uniqueness: true
end
