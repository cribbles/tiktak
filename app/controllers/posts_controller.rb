class PostsController < ApplicationController
  before_action :ensure_logged_in, only: :update
  before_action :ensure_admin,     only: :destroy

  def show
    @post  = post 
    @topic = Topic.find_by(id: post.topic_id)
  end

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
      redirect_to topic_path(topic, page: last_page_of(topic),
                                    anchor: "p" + @post.id.to_s)
    else
      render 'new'
    end
  end

  def update 
    post.update_attributes(flagged: true) 
    flash[:info] = "Post has been marked for moderation. Thanks!"
    redirect_to request.referrer || root_url
  end

  def destroy
    id = post.id
    post.update_attributes(visible: false, flagged: false)
    flash[:danger] = "Post #{id} was successfully deleted."
    redirect_to request.referrer || root_url
  end

  private

    def post_params
      params.require(:post).permit(:topic_id, :content, :quote, :contact)
    end

    def topic
      id = params[:topic_id] || post_params[:topic_id]
      Topic.find_by(id: id, visible: true)
    end

    def post
      topic.posts.find_by(id: params[:id], visible: true)
    end

    def last_page_of(topic)
      topic.posts.paginate(page: 1, per_page: 20).total_pages
    end
end
