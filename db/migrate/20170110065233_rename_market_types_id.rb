class RenameMarketTypesId < ActiveRecord::Migration[5.0]
  def change
  	rename_column :markets, :market_types_id, :market_type_id
  end
end
