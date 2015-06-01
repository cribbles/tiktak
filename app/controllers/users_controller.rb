class UsersController < ApplicationController
  before_action :logged_in, only: :show

  def show
    redirect_to root_url if current_user.nil?
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Thanks for signing up!"
      redirect_to profile_path
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def logged_in
      unless logged_in?
        flash[:danger] = "You must be logged in to view this page."
        redirect_to login_url
      end
    end
end
