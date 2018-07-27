class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_locale
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def create_notification recipient, notifiable
    Notification.create(actor: current_user, recipient: recipient,
      action: t("post"), notifiable: notifiable).send_notification_email
  end
end
