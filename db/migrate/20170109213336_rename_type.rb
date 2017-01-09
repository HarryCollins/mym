class RenameType < ActiveRecord::Migration[5.0]
  def change
  	rename_column :market_types, :type, :market_type
  end
end
