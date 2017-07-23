class ChangeResultTypeInMarketOutcome < ActiveRecord::Migration[5.0]
  def change
	change_column :market_outcomes, :result, "integer USING result::integer"
	change_column :results, :result, "integer USING result::integer"
  end
end
