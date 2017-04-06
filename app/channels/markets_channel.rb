class MarketsChannel < ApplicationCable::Channel 

  def subscribed
  	stop_all_streams

    #all users in specific market
    stream_from "all_users_in_market_#{params[:market]}"
    
    #specific user in all markets
    stream_from "mentioned_user_#{current_user.id}"

    #specific user in specific market
	stream_from "specific_user_#{current_user.id}_in_market_#{params[:market]}"
  end
  
end 