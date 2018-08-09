class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_locale
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def create_notifications recipients, action, notifiable
    case notifiable.is_a?
    when User
      @url = user_url notifiable.id
    when Lesson
      @url = lesson_url notifiable.id
    when Comment
      @url = lesson_url notifiable.lesson.id
    end
    recipients.each do |recipient|
      Notification.create(actor: current_user, recipient: recipient,
        action: action, notifiable: notifiable, notification_url: @url)
                  .send_notification_email
    end
  end
  private

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "flash.pls_login"
    redirect_to login_url
  end
end
