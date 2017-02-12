class FixLayAmountColumnName < ActiveRecord::Migration[5.0]
  def change
  	rename_column :backs, :amount, :original_amount
  end
end
