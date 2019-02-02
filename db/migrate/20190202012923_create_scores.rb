class CreateScores < ActiveRecord::Migration[5.2]
  def change
    create_table :scores do |t|
      t.references :quiz, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :grade

      t.timestamps
    end
  end
end
