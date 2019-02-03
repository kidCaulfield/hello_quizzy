class AddColumnToScores < ActiveRecord::Migration[5.2]
  def change
    add_column :scores, :total, :integer
  end
end
