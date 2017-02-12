class AddCurrentAmountToBacks < ActiveRecord::Migration[5.0]
  def change
    add_column :backs, :current_amount, :decimal
  end
end
