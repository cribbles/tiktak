class PostsController < ApplicationController
  before_action :ensure_topic_exists
  before_action :ensure_logged_in,        only: :update
  before_action :ensure_admin,            only: :destroy
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
      @post.update_attributes(hellbanned: true) if hellbanned?
      redirect_to topic_path_for(@post) 
    else
      render 'new'
    end
  end

  def update 
    post.update_attributes(flagged: true) unless hellbanned?
    flash[:info] = "Post has been marked for moderation. Thanks!"
    redirect_to request.referrer || root_url
  end

  def destroy
    post.update_attributes(visible: false, flagged: false)
    flash[:danger] = "Post #{params[:id]} was successfully deleted."
    redirect_to request.referrer || root_url
  end

  private

    def post_params
      params.require(:post).permit(:topic_id, :content, :quote, :contact)
    end

    def topic
      id = params[:topic_id] || post_params[:topic_id]
      Topic.find_by(displayable(id: id))
    end

    def post
      id = params[:id]
      topic.posts.find_by(displayable(id: id))
    end

    def ensure_topic_exists
      redirect_to root_url unless topic
    end

    def ensure_post_exists
      redirect_to root_url unless post
    end

    def ensure_quote_associated
      redirect_to root_url if params[:id] && !post
    end
end
