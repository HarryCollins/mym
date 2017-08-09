class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
    	t.references :results, :market, foreign_key: true, index: true
    	t.references :payer
    	t.references :receiver
    	t.decimal :amount
    	t.timestamps
    end
  end
end
