class Notification < ApplicationRecord
  belongs_to :recipient, class_name: User.name
  belongs_to :actor, class_name: User.name
  belongs_to :notifiable, polymorphic: true
  after_create_commit {NotificationBroadcastJob.perform_later self.recipient.notifications.count}

  def send_notification_email
    # UserMailer.notify(recipient).deliver_later
  end
end
