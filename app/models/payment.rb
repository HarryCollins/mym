class Payment < ApplicationRecord
	belongs_to :market
	belongs_to :payer, class_name: 'User', foreign_key: 'payer_id'
	belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'
end
