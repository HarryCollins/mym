class MessagesController < ApplicationController

	def create
		message = Message.new(message_params)
		market = Market.find(params[:id])
		message.user = current_user
		if message.save
			redirect_to market_path(market)
		else 
			redirect_to market_path(market)
		end
	end

	private

	def message_params
	  params.require(:message).permit(:message_text, :market_id)
	end

end