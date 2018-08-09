class CreateRoomUserRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :room_user_relations do |t|
      t.integer :user_id
      t.integer :chat_room_id
      t.timestamps
    end
  end
end
