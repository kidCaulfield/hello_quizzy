class RenameGradeToPointsColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :scores, :grade, :point
  end
end
