require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  def setup
    @user = users(:fred)
    @request = ActionController::TestRequest.new
    @request.remote_ip = '1.2.3.4'
  end

  test "account_activation" do
    @user.activation_token = User.new_token
    mail = UserMailer.account_activation(@user)
    assert_equal "Activate your account",  mail.subject
    assert_equal [@user.email],            mail.to
    assert_equal ["noreply@example.com"],  mail.from
    assert_match @user.activation_token,   mail.body.encoded
    assert_match CGI::escape(@user.email), mail.body.encoded
#    assert_match '1.2.3.4',                mail.body.encoded
  end

  test "password_reset" do
    @user.reset_token = User.new_token
    mail = UserMailer.password_reset(@user)
    assert_equal "Reset your password",    mail.subject
    assert_equal [@user.email],            mail.to
    assert_equal ["noreply@example.com"],  mail.from
    assert_match @user.reset_token,        mail.body.encoded
    assert_match CGI::escape(@user.email), mail.body.encoded
#    assert_match '1.2.3.4',                mail.body.encoded
  end
end
