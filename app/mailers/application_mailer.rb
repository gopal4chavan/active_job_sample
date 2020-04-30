class ApplicationMailer < ActionMailer::Base
  default from: ENV["EMAIL_ID"]
  layout 'mailer'
end
