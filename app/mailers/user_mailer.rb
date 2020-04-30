class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.test_notify.subject
  #
  def test_notify(email)
    mail to: email
  end
end
