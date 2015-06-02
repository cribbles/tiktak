class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Activate your account"
  end

  def password_reset(user)
    @user = user
    mail to: "to@example.org"
  end
end
