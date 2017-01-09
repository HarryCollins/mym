class CreateMarketOutcomes < ActiveRecord::Migration[5.0]
  def change
    create_table :market_outcomes do |t|
      t.text :outcome
      t.references :markets, index: true, foreign_key: true
      t.timestamps
    end
  end
end
