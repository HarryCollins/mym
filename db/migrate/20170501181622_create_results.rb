class CreateResults < ActiveRecord::Migration[5.0]
  def change
    create_table :results do |t|
      t.boolean :result
      t.references :winner, index: true, foreign_key: true
      t.references :loser, index: true, foreign_key: true
	  t.references :market_outcome, index: true, foreign_key: true
	  t.decimal :pnl
      t.timestamps
    end
  end
end
