class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :markets, :status_id, :market_status_id
  end
end
