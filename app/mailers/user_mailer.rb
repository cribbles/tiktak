class UserMailer < ApplicationMailer

  def account_activation(user, client_ip = '0.0.0.0')
    @user = user
    @client_ip = client_ip
    mail to: user.email, subject: "Activate your account"
  end

  def password_reset(user, client_ip = '0.0.0.0')
    @user = user
    @client_ip = client_ip
    mail to: user.email, subject: "Reset your password"
  end
end
