class PasswordResetsController < ApplicationController
  before_action :get_user,         only: [:edit, :update]
  before_action :valid_user,       only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email(request.remote_ip)
      message = "Check your e-mail for instructions to reset your password."
      flash[:info] = message
      redirect_to root_url
    else
      flash.now[:danger] = "No account exists for that e-mail."
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      flash.now[:danger] = "Your password can't be blank."
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = "Your password has been reset."
      redirect_to profile_url
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user   = current_user
      @user ||= User.find_by(email: params[:email])
    end

    def valid_user
      unless logged_in? || (@user && @user.activated? &&
                            @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

    def check_expiration
      if !logged_in? && @user.password_reset_expired?
        flash[:danger] = "Your password reset token has expired."
        redirect_to lost_password_url
      end
    end
end
