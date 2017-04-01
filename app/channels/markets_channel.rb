class MarketsChannel < ApplicationCable::Channel 

  def subscribed
    #all messages in market
    stream_from "market_messages_#{params[:market]}"
    
    #all messages @ current user
    stream_from "market_messages_user_#{current_user.id}"
    
    #all users in market
    stream_from "market_users_#{params[:market]}"
  end
  
end 