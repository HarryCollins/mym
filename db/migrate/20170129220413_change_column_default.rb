class ChangeColumnDefault < ActiveRecord::Migration[5.0]
  def change
  	change_column :user_markets, :is_founder, :boolean, default: false
  end
end
