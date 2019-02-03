class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :scores, :points, :results
  end
end
