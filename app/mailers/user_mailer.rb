class UserMailer < ApplicationMailer
  def notify user
    @user = user
    mail to: user.email, subject: t("notification")
  end
end
