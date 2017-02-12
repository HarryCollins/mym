class RemoveTimeBetMadeFromLays < ActiveRecord::Migration[5.0]
  def change
    remove_column :lays, :time_bet_made, :datetime
  end
end
