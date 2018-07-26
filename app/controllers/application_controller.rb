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
  private

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "flash.pls_login"
    redirect_to login_url
  end
end
