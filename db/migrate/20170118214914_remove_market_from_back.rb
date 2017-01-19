class RemoveMarketFromBack < ActiveRecord::Migration[5.0]
  def change
    remove_column :backs, :market_id, :integer
  end
end
