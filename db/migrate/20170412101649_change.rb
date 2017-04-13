class Change < ActiveRecord::Migration[5.0]
  def change
    rename_table :statuses, :market_statuses
  end
end
