class RemoveResultsFromScores < ActiveRecord::Migration[5.2]
  def change
    remove_column :scores, :results
  end
end
