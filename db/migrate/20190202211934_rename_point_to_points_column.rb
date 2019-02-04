class RenamePointToPointsColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :scores, :point, :points
  end
end
