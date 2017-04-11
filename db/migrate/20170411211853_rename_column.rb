class RenameColumn < ActiveRecord::Migration[5.0]
  def change
  	rename_column :statuses, :status, :market_status
  end
end
