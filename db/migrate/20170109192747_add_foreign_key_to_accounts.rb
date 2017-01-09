class AddForeignKeyToAccounts < ActiveRecord::Migration[5.0]
  def change
  	add_foreign_key :accounts, :users
  end
end
