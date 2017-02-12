class ChangeColumnDefaultBack < ActiveRecord::Migration[5.0]
  def change
  	change_column_default :backs, :is_full, :false
  end
end
