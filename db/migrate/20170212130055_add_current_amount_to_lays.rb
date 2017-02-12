class AddCurrentAmountToLays < ActiveRecord::Migration[5.0]
  def change
    add_column :lays, :current_amount, :decimal
  end
end
