class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
    	t.references :market, index: true, foreign_key: true
    	t.references :user, index: true, foreign_key: true
    	t.text :message_text
    	t.timestamps
    end
  end
end
