class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if !user.activated?
        message = "Please check your e-mail to activate your account."
        flash.now[:warning] = message
        render 'new'
      else
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or profile_url
      end
    else
      flash.now[:danger] = 'Invalid e-mail or password.'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash.now[:info] = 'You have been logged out.'
    redirect_to root_url
  end
end
