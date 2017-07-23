class User < ApplicationRecord
	has_many :user_markets, dependent: :destroy
	has_many :markets, through: :user_markets
	has_many :messages
	has_many :backs
	has_many :lays
	has_many :wins, class_name: 'Result', foreign_key: 'layer_id'
	has_many :loses, class_name: 'Result', foreign_key: 'backer_id'

 	before_save { self.email = email.downcase }

	validates :firstname, presence: true
	validates :secondname, presence: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 100 },
										uniqueness: {case_sensitive: false},
										format: {with: VALID_EMAIL_REGEX}, on: :create
	validates :password, presence: true, length: { minimum: 8, maximum: 72}, on: :create

	has_secure_password


end
