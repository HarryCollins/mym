class ChangeColumnNamePnL < ActiveRecord::Migration[5.0]
  def change
  	rename_column :results, :pnl, :backer_returns
  end
end
