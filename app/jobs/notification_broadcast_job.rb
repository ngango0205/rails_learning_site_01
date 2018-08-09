class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform notification, counter
    ActionCable.server.broadcast(
      "notification_channel_#{notification.recipient.id}",
      notification: notification, counter: counter
    )
  end
end
