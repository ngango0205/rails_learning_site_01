class CreateLessonCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :lesson_categories do |t|
      t.integer :category_id
      t.integer :lesson_id

      t.timestamps
    end
  end
end
