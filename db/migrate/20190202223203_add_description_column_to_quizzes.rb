class AddDescriptionColumnToQuizzes < ActiveRecord::Migration[5.2]
  def change
    add_column :quizzes, :description, :text
  end
end
