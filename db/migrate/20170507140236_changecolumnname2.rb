class Changecolumnname2 < ActiveRecord::Migration[5.0]
  def change
  	rename_column :results, :loser_returns, :winner_pnl
  end
end
