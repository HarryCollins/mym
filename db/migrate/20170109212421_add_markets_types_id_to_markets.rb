class AddMarketsTypesIdToMarkets < ActiveRecord::Migration[5.0]
  def change
    add_column :markets, :market_types_id, :integer, index: true, foreign_key: true
  end
end
