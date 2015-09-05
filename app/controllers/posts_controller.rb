class PostsController < ApplicationController
  include TopicsLibrary

  before_action :ensure_topic_exists
  before_action :ensure_admin,            only: :destroy
  before_action :ensure_logged_in,        only: :update
  before_action :ensure_quote_associated, only: [:new, :create]
  before_action :ensure_post_exists,      only: [:update, :destroy]

  def new
    @topic = topic
    @quote = post
    @post  = @topic.posts.build
  end

  def create
    @post = topic.posts.build(post_params)

    if captcha_verified(@post) && @post.save
      topic.update_attributes(last_posted_hb: @post.created_at)
      topic.update_attributes(last_posted: @post.created_at) unless hellbanned?
      @post.update_attributes(ip_address: request.remote_ip)
      @post.update_attributes(user_id: current_user.id) if logged_in?
      @post.hellban if hellbanned?

      redirect_to topic_path_for(@post)
    else
      render 'new'
    end
  end

  def update
    post.flag unless hellbanned?

    flash[:info] = "Post has been marked for moderation. Thanks!"
    redirect_to request.referrer || root_url
  end

  def destroy
    post.remove

    flash[:danger] = "Post #{params[:id]} was successfully deleted."
    redirect_to request.referrer || root_url
  end

  private

  def post_params
    params
      .require(:post)
      .permit(:topic_id, :content, :quote, :contact)
  end

  def topic
    topic_id = params[:topic_id] || post_params[:topic_id]

    Topic
      .joins(:posts)
      .joins("LEFT OUTER JOIN users ON users.id = posts.user_id")
      .find_by(displayable( where: { id: topic_id }))
  end

  def post
    topic.posts.find_by(displayable(where: { id: params[:id] }))
  end

  def ensure_post_exists
    redirect_to root_url if post.nil?
  end

  def ensure_quote_associated
    redirect_to root_url if params[:id] && post.nil?
  end
end
