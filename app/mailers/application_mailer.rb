class ApplicationMailer < ActionMailer::Base
  default from: ENV["EMAIL_SEND"]
  layout "mailer"
end
