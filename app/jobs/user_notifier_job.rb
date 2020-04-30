class UserNotifierJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    email_id = User.find(user_id).email
    UserMailer.test_notify(email_id).deliver_later
  end
end
