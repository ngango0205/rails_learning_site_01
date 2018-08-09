class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel_#{current_user.id}"
  end

  def unsubscribed; end

  def send_message data
    current_user.messages.create(content: data["message"],
      chat_room_id: data["room_id"])
  end
end
