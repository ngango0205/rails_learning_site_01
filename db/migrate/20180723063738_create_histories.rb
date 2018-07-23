class CreateHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :histories do |t|
      t.integer :user_id
      t.integer :lesson_id
      t.integer :role

      t.timestamps
    end
  end
end
