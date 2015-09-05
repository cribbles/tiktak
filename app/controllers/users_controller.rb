class UsersController < ApplicationController
  before_action :ensure_logged_in, only: :show

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if captcha_verified(@user) && @user.save
      send_email(:account_activation, email_params)

      msg  = "Thanks for signing up!  Please check your e-mail "
      msg += "to activate your account."
      flash[:info] = msg

      redirect_to root_url
    else
      render 'new'
    end
  end

  private

  def user_params
    params
      .require(:user)
      .permit(:email, :password, :password_confirmation)
  end

  def email_params
    { user: @user, ip_address: request.remote_ip }
  end
end
