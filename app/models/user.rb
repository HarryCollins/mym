class User < ApplicationRecord
	has_many :user_markets, dependent: :destroy
	has_many :markets, through: :user_markets
	has_many :messages
	has_many :backs
	has_many :lays
	#TODO Are the below two references doing anything?
	has_many :wins, class_name: 'Result', foreign_key: 'layer_id'
	has_many :loses, class_name: 'Result', foreign_key: 'backer_id'

	has_many :payments, class_name: 'Payment', foreign_key: 'payer_id'
	has_many :receipts, class_name: 'Payment', foreign_key: 'receiver_id'

	before_create :confirmation_token
 	before_save { self.email = email.downcase }

	validates :firstname, presence: true
	validates :secondname, presence: true
	validates :username, presence: true, uniqueness: true, length: { minimum: 6, maximum: 72}, on: :create
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 100 },
										uniqueness: {case_sensitive: false},
										format: {with: VALID_EMAIL_REGEX}
	validates :password, presence: true, length: { minimum: 8, maximum: 72}, on: :create

	has_secure_password

	def email_activate
		self.email_confirmed = true
		self.confirm_token = nil
		save!
	end


private

	def confirmation_token
		if self.confirm_token.blank?
		  self.confirm_token = SecureRandom.urlsafe_base64.to_s
		end
	end

end
