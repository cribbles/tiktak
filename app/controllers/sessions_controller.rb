class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or profile_url
      else
        message  = "Your account has not been activated yet. "
        message += "Check your e-mail for the activation link."
        flash.now[:warning] = message
        render root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash.now[:info] = 'You have been logged out.'
    redirect_to root_url
  end
end
