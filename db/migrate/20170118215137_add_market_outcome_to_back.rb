class AddMarketOutcomeToBack < ActiveRecord::Migration[5.0]
  def change
    add_reference :backs, :market_outcome, foreign_key: true, index: true
  end
end
