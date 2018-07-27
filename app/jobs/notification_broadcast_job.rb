class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform counter
    ActionCable.server.broadcast "notification_channel_#{cookies.signed[:user_id]}", counter: counter
  end
end
