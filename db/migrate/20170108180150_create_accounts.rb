class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
	  t.integer :user_id
	  t.integer :balance
      t.timestamps
    end
  end
end
