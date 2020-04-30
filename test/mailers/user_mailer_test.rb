require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "test_notify" do
    mail = UserMailer.test_notify
    assert_equal "Test notify", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
