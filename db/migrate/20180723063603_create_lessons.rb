class CreateLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :lessons do |t|
      t.string :name
      t.text :description
      t.text :content
      t.integer :category_id
      t.integer :like_number
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
