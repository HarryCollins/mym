class RemoveMarketFromLay < ActiveRecord::Migration[5.0]
  def change
    remove_column :lays, :market_id, :integer
  end
end
