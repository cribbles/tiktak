class UsersController < ApplicationController
  before_action :ensure_logged_in, only: :show

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email(request.remote_ip)
      message  = "Thanks for signing up!  Please check your e-mail "
      message += "to activate your account."
      flash[:info] = message
      redirect_to root_url
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def ensure_logged_in
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
