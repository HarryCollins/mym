class MarketsController::ProcessMarketPayments

	#this class calculates the most efficient way of users settling up after a market is completed

	def initialize(market)
		@market = market
	end

	def process
		users_pnl_array = create_array
		sorted_users_pnl_array = sort_by_pnl_asc(users_pnl_array)
		payments_array = calculate_easiest_payments(sorted_users_pnl_array, Array.new)
		save_payments_to_database(payments_array)
	end

	def create_array
		pnl_array = Array.new
		@market.users.each do |user|
			single_user_pnl_hash = Hash.new
			user_pnl = @market.results.where(backer: user).sum(:backer_pnl)
			user_pnl += @market.results.where(layer: user).sum(:layer_pnl)
			if user_pnl != 0
				single_user_pnl_hash[:id] = user.id
				single_user_pnl_hash[:pnl] = user_pnl
				pnl_array.push(single_user_pnl_hash)
			end
		end
		#sum of all hash values should be 0 - put in a test here?
		return pnl_array
	end

	def sort_by_pnl_asc(users_pnl_array)
		sorted_array = users_pnl_array.sort_by { |v| v[:pnl] }
		return sorted_array
	end

	def calculate_easiest_payments(sorted_users_pnl_array, payments_array)

		#base case
		if sorted_users_pnl_array.length < 2
			return payments_array
		end

		payment_hash = Hash.new

		payment_hash[:payer] = sorted_users_pnl_array.first[:id]
		payment_hash[:receiver] = sorted_users_pnl_array.last[:id]

		if sorted_users_pnl_array.first[:pnl].abs > sorted_users_pnl_array.last[:pnl].abs
			#lowest pnl is lower than highest pnl is high
			payment_hash[:amount] = sorted_users_pnl_array.last[:pnl].abs
			sorted_users_pnl_array.first[:pnl] = sorted_users_pnl_array.first[:pnl] + sorted_users_pnl_array.last[:pnl]
			sorted_users_pnl_array.pop

		elsif sorted_users_pnl_array.first[:pnl].abs < sorted_users_pnl_array.last[:pnl].abs
			#highest pnl is higher than lowest pnl is low
			payment_hash[:amount] = sorted_users_pnl_array.first[:pnl].abs
			sorted_users_pnl_array.last[:pnl] = sorted_users_pnl_array.last[:pnl] + sorted_users_pnl_array.first[:pnl]
			sorted_users_pnl_array.shift

		elsif sorted_users_pnl_array.first[:pnl].abs == sorted_users_pnl_array.last[:pnl].abs
			#highest pnl and lowest pnl are exactly equal
			payment_hash[:amount] = sorted_users_pnl_array.first[:pnl].abs
			sorted_users_pnl_array.shift
			sorted_users_pnl_array.pop
		end

		payments_array.push(payment_hash)


		calculate_easiest_payments(sorted_users_pnl_array, payments_array)
	end

	def save_payments_to_database(payments_array)
		payments_array.each do |payment_from_array|
			payment_for_db = Payment.new(amount: payment_from_array[:amount], payer_id: payment_from_array[:payer], receiver_id: payment_from_array[:receiver], market: @market)
			payment_for_db.save
		end
	end

end