class SessionsController < ApplicationController

  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    user = User.find_by(email: email)

    if user && user.authenticate(password)
      if user.activated?
        log_in user
        remember_user? ? remember(user) : forget(user)

        redirect_back_or(root_url)
      else
        msg = "Check your e-mail to activate your account."
        flash.now[:warning] = msg

        render 'new'
      end
    else
      flash.now[:danger] = 'Invalid e-mail or password.'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?

    redirect_to root_url
  end

  private

  def remember_user?
    params[:session][:remember_me] == '1'
  end
end
