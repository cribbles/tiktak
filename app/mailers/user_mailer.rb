class UserMailer < ApplicationMailer

  def account_activation(user: user, ip_address: nil)
    @user = user
    @client_ip = ip_address
    mail to: user.email, subject: "Activate your account"
  end

  def password_reset(user: user, ip_address: nil)
    @user = user
    @client_ip = ip_address 
    mail to: user.email, subject: "Reset your password"
  end
end
