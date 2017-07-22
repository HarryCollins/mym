class CreateResults < ActiveRecord::Migration[5.0]
  def change
    create_table :results do |t|
      t.boolean :result
      t.references :winner, index: true, index: true
      t.references :loser, index: true, index: true
	    t.references :market_outcome, index: true, foreign_key: true
	    t.decimal :pnl
      t.timestamps
    end

    add_foreign_key :results, :users, column: :winner_id
    add_foreign_key :results, :users, column: :loser_id

  end
end
