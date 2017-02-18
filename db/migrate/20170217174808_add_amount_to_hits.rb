class AddAmountToHits < ActiveRecord::Migration[5.0]
  def change
    add_column :hits, :amount, :decimal
  end
end
