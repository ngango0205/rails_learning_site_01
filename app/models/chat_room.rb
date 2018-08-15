class ChatRoom < ApplicationRecord
  has_many :room_user_relation, foreign_key: :chat_room_id
  has_many :users, through: :room_user_relation
  has_many :messages
end
