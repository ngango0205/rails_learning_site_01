class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :search
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def create_notifications recipients, action, notifiable
    case notifiable
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

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit :role, :name, :email, :password,
        :password_confirmation, :address
    end
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit :name, :email, :password,
        :password_confirmation, :current_password
    end
  end

  def search
    @q = User.search params[:q]
  end
end
