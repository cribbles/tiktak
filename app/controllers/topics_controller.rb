class TopicsController < ApplicationController
  before_action :ensure_admin,    only: :destroy
  before_action :ensure_exists,   only: [:show, :destroy]
  before_action :increment_views, only: :show

  def index
    @topics = Topic.where(displayable)
                   .order(order)
                   .paginate(page: params[:page], per_page: 20)
  end

  def show
    @topic = topic
    @posts = topic.posts
                  .order(created_at: :asc)
                  .paginate(page: params[:page], per_page: 20)
  end

  def new
    @topic = Topic.new
    @topic.posts.build
  end

  def create
    @topic = Topic.new(topic_params)
    if captcha_verified(@topic) && @topic.save
      post = @topic.posts.first

      @topic.update_attributes(last_posted:    post.created_at,
                               last_posted_hb: post.created_at)
      update_each(@topic, post) {{ user_id: current_user.id }} if logged_in?
      update_each(@topic, post) {{ hellbanned: true }} if hellbanned?

      redirect_to @topic
    else
      render 'new'
    end
  end

  def destroy
    topic.remove!

    flash[:danger] = "Topic #{params[:id]} was successfully removed."
    redirect_to request.referrer || root_url
  end

  private

    def topic_params
      params.require(:topic).permit(:title,
                                    posts_attributes: [:content, :contact])
    end

    def topic
      Topic.find_by(displayable(id: params[:id]))
    end

    def ensure_exists
      redirect_to root_url unless topic
    end

    def increment_views
      topic.update_attributes(views: topic.views+1)
    end

    def order
      last_posted = hellbanned? ? :last_posted_hb : :last_posted
      { last_posted => :desc }
    end
end
