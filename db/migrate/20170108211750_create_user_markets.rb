class CreateUserMarkets < ActiveRecord::Migration[5.0]
  def change
    create_table :user_markets do |t|
      t.integer :user_id, :market_id
      t.boolean :is_founder
      t.timestamps
    end
  end
end
