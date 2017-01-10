class RenameMarketsId < ActiveRecord::Migration[5.0]
  def change
  	rename_column :market_outcomes, :markets_id, :market_id
  end
end
