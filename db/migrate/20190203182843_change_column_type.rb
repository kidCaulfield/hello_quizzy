class ChangeColumnType < ActiveRecord::Migration[5.2]
  def change
    def up
      change_column :scores, :points, :json
    end
  
    def down
      change_column :scores, :points, :integer
    end
  end
end
