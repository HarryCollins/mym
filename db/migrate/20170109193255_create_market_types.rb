class CreateMarketTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :market_types do |t|
      t.string :type
      t.references :markets, index: true, foreign_key: true
      t.timestamps
    end
  end
end 
