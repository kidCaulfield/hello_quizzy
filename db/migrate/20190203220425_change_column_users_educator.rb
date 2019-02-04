class ChangeColumnUsersEducator < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :educator, :boolean, default: true
  end
end
