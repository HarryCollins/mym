class AddMarketOutcomeToLay < ActiveRecord::Migration[5.0]
  def change
    add_reference :lays, :market_outcome, foreign_key: true, index: true
  end
end
