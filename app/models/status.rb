class Status < ApplicationRecord
	has_many :markets
	validates :status, presence: true
end
