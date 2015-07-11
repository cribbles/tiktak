class AdminController < ApplicationController
  include TopicsLibrary
  before_action :ensure_admin

  def index
    @flagged_posts = Post.where(flagged: true)
  end

  def update
    Post.find_by(id: params[:id]).unflag

    flash[:info] = "Report for post #{params[:id]} has been dismissed."
    redirect_to queue_path 
  end
end
