class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform message, current_user_id
    @users = message.chat_room.users
    current_user = User.find_by(id: current_user_id)
    @users.each do |user|
      ActionCable.server.broadcast "chat_channel_#{user.id}",
        message: (render_message message)
    end
  end

  private

  def render_message message
    MessagesController.render partial: "messages/message",
      locals: {message: message}
  end
end
