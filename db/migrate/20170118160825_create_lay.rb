class CreateLay < ActiveRecord::Migration[5.0]
  def change
    create_table :lays do |t|
      t.decimal :amount
      t.datetime :time_bet_made
      t.decimal :odds
      t.boolean :is_full
      t.references :market, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.timestamps
    end
  end
end
