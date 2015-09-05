class PasswordResetsController < ApplicationController
  before_action :ensure_valid_user, only: [:edit, :update]
  before_action :check_expiration,  only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: user_email)

    if @user.nil?
      flash.now[:danger] = "No account exists for that e-mail."
      render 'new'
    else
      @user.create_reset_digest
      send_email(:password_reset, email_params)

      msg = "Check your e-mail for instructions to reset your password."
      flash[:info] = msg

      redirect_to root_url
    end
  end

  def edit
    @user = user
  end

  def update
    @user = user

    if params[:user][:password].empty?
      flash.now[:danger] = "Your password can't be blank."
      render 'edit'
    elsif logged_in? && !user.authenticate(old_password)
      flash.now[:danger] = "Your current password was entered incorrectly."
      render 'edit'
    elsif user.update_attributes(user_params)
      log_in user if !logged_in?

      flash[:success] = "Your password has been reset."
      redirect_to root_url
    else
      render 'edit'
    end
  end

  private

  def user_params
    user_params = [:password, :password_confirmation]
    user_params << :old_password if user

    params.require(:user).permit(*user_params)
  end

  def email_params
    { user: user, ip_address: request.remote_ip }
  end

  def user
    current_user || User.find_by(email: params[:email])
  end

  def user_email
    params[:password_reset][:email].downcase
  end

  def user_with_token?
    user && user.activated? && user.authenticated?(:reset, params[:id])
  end

  def ensure_valid_user
    redirect_to root_url unless logged_in? || user_with_token?
  end

  def old_password
    params[:user].delete(:old_password)
  end

  def check_expiration
    if !logged_in? && user.password_reset_expired?
      flash[:danger] = "Your password reset token has expired."
      redirect_to lost_password_url
    end
  end
end
