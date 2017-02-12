class RemoveTimeBetMadeFromBacks < ActiveRecord::Migration[5.0]
  def change
    remove_column :backs, :time_bet_made, :datetime
  end
end
