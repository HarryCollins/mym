class ChangeColumnDefaultLay < ActiveRecord::Migration[5.0]
  def change
  	change_column_default :lays, :is_full, :false
  end
end
