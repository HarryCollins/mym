class Account < ApplicationRecord
	belongs_to :user
	validates :balance, numericality: { greater_than_or_equal_to: 0,  message: "- you do not have sufficient funds" }
	validates :user, presence: true, uniqueness: true
end
