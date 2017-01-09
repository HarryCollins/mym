class CreateMarkets < ActiveRecord::Migration[5.0]
  def change
    create_table :markets do |t|
	  t.integer :user_market_id
      t.string :name
      t.text :description
      t.timestamps
    end
  end
end
