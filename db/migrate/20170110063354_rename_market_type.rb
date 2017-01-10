class RenameMarketType < ActiveRecord::Migration[5.0]
  def change
  	rename_column :market_types, :market_type, :mechanism
  end
end
