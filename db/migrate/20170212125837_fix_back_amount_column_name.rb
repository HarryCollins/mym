class FixBackAmountColumnName < ActiveRecord::Migration[5.0]
  def change
  	rename_column :lays, :amount, :original_amount
  end
end
