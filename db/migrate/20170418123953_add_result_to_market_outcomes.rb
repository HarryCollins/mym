class AddResultToMarketOutcomes < ActiveRecord::Migration[5.0]
  def change
    add_column :market_outcomes, :result, :boolean
  end
end
