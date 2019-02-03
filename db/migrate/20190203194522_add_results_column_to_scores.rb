class AddResultsColumnToScores < ActiveRecord::Migration[5.2]
  def change
      add_column :scores, :results, :json
  end
end
