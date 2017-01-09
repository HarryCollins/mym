class RemoveMarketsIdFromMarketTypes < ActiveRecord::Migration[5.0]
  def change
    remove_column :market_types, :markets_id, :integer
  end
end
