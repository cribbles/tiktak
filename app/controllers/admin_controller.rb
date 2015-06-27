class AdminController < ApplicationController
  before_action :ensure_admin

  def index
    @flagged_posts = Post.where(flagged: true)
  end

  def update
    post = Post.find_by(id: params[:id])
    post.update_attributes(flagged: false)
    flash[:info] = "Report for post #{params[:id]} has been dismissed."
    redirect_to queue_path 
  end
end
