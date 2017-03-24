class MessagesController < ApplicationController

	def create
		message = Message.new(message_params)
		message.user = current_user
		market = Market.find(params[:id])
		@market = MarketPresenter.new(market, view_context)
		can_chat_validation = BetValidations::BetValidation.new(@market, current_user)
		
		if can_chat_validation.is_member?
			if message.save
				respond_to do |format|
					format.html { redirect_to market_path(@market) }
					format.js { }
				end
			else 
				redirect_to market_path(@market)
			end
		else
			can_chat_validation.add_errors
			flash[:danger] = @market.errors.full_messages.join("<br>").html_safe
			render js: %(window.location.pathname='#{market_path(@market)}')
		end
	end

	private

	def message_params
	  params.require(:message).permit(:message_text, :market_id)
	end

end