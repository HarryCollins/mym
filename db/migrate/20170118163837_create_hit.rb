class CreateHit < ActiveRecord::Migration[5.0]
  def change
    create_table :hits do |t|
      t.references :back, index: true, foreign_key: true
      t.references :lay, index: true, foreign_key: true
    end
  end
end
