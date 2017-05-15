class Changecolumnname < ActiveRecord::Migration[5.0]
  def change
  	rename_column :results, :backer_returns, :winner_returns
  	rename_column :results, :layer_returns, :loser_returns
  end
end
