class ChangeResults < ActiveRecord::Migration[5.0]
  def change
	rename_column :results, :winner_id, :backer_id
	rename_column :results, :loser_id, :layer_id
	rename_column :results, :winner_returns, :backer_pnl
	rename_column :results, :winner_pnl, :layer_pnl		
  end
end
