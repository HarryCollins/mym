class RemoveUserMarketIdFromMarkets2 < ActiveRecord::Migration[5.0]
  def change
  	remove_column :markets, :user_market_id
  end
end
