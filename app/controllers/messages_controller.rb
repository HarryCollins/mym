class MessagesController < ApplicationController

	before_action :require_user, only: [:create]

	def create
		@message = Message.new(message_params)
		@message.user = current_user
		market = Market.find(params[:id])
		@market = MarketPresenter.new(market, view_context)


		
		if @message.save
			#broadcast message
			ActionCable.server.broadcast "all_users_in_market_#{market.id}",
								message: render_message(@message), new_message: true, user_id: current_user.id

			#broadcast all '@' mentions
			@message.mentions.each do |mention|
				ActionCable.server.broadcast "mentioned_user_#{mention.id}",
												mention: true, market: market.name, from_user:current_user.username
			end
		else	
			respond_to do |format|
				format.html { redirect_to market_path(@market) }
				format.js {}
			end
		end
		

		
		# if message.save
		# 	#broadcast message
		# 	ActionCable.server.broadcast "all_users_in_market_#{market.id}",
		# 						message: render_message(message), new_message: true, user_id: current_user.id

		# 	#broadcast all '@' mentions
		# 	message.mentions.each do |mention|
		# 		ActionCable.server.broadcast "mentioned_user_#{mention.id}",
		# 										mention: true, market: market.name, from_user:current_user.username
		# 	end
		# else 



		# end

	end

	private

		def message_params
			params.require(:message).permit(:message_text, :market_id)
		end
	
		def render_message(message)
			render(partial: 'message', locals: { message: message })
		end

end