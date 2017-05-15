class AddHitToResults < ActiveRecord::Migration[5.0]
  def change
    add_reference :results, :hit, foreign_key: true
  end
end
