class AddLayerReturnsToResults < ActiveRecord::Migration[5.0]
  def change
    add_column :results, :layer_returns, :decimal
  end
end
