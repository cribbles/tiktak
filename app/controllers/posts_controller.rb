class PostsController < ApplicationController
  before_action :ensure_logged_in, only: :update
  before_action :admin_check,      only: [:update, :destroy]

  def show
    @post  = Post.find_by(id: params[:id])
    @topic = Topic.find_by(id: @post.topic_id)
  end

  def new
    @topic = Topic.find_by(id: params[:topic_id])
    @quote = @topic.posts.find_by(id: params[:id])
    @quote = nil unless @quote && @quote.visible
    @post  = @topic.posts.build
  end

  def create
    @topic = Topic.find_by(id: post_params[:topic_id])
    @post  = @topic.posts.build(post_params)
    if captcha_verified(@post) && @post.save
      @topic.update_attributes(last_posted: @post.created_at)
      @post.update_attributes(ip_address: request.remote_ip)
      @post.update_attributes(user_id: current_user.id) if logged_in?
      redirect_to topic_path(@topic, page: last_page_of(@topic),
                                     anchor: "p" + @post.id.to_s)
    else
      render 'new'
    end
  end

  def update 
    @post = Post.find_by(id: params[:id])
    @post.update_attributes(flagged: true)
    flash[:info] = "Post has been marked for moderation. Thanks!"
    redirect_to request.referrer || root_url
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.update_attributes(visible: false)
    flash[:danger] = "Post #{@post.id} was successfully deleted."
    redirect_to request.referrer || root_url
  end

  private

    def post_params
      params.require(:post).permit(:topic_id, :content, :quote, :contact)
    end

    def last_page_of(topic)
      topic.posts.paginate(page: 1, per_page: 20).total_pages
    end
end
