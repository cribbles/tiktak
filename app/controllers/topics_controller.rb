class TopicsController < ApplicationController
  include TopicsLibrary

  before_action :ensure_admin,        only: :destroy
  before_action :ensure_topic_exists, only: [:show, :destroy]
  before_action :increment_views,     only: :show

  def index
    @topics = Topic.indexed
                   .where(displayable)
                   .order(display_order)
                   .paginate(page: params[:page], per_page: 20)

    respond_to do |format|
      format.html { render :index }
      format.json { render :index }
    end
  end

  def show
    @topic = topic
    @posts = topic.posts
                  .order(created_at: :asc)
                  .paginate(page: params[:page], per_page: 20)

    respond_to do |format|
      format.html { render :show }
      format.json { render :show }
    end
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

      [@topic, post].each do |table|
        table.update_attributes(user_id: current_user.id) if logged_in?
        table.update_attributes(hellbanned: true) if hellbanned?
      end

      redirect_to @topic
    else
      render 'new'
    end
  end

  def destroy
    topic.remove

    flash[:danger] = "Topic #{params[:id]} was successfully removed."
    redirect_to request.referrer || root_url
  end

  private

  def topic_params
    params
      .require(:topic)
      .permit(:title, posts_attributes: [:content, :contact])
  end

  def topic
    Topic
      .joins(:posts)
      .joins("LEFT OUTER JOIN users ON users.id = posts.user_id")
      .find_by(displayable( where: { id: params[:id] }))
  end

  def increment_views
    topic.increment_views
  end

  def display_order
    last_posted = (hellbanned? ? :last_posted_hb : :last_posted)

    { last_posted => :desc }
  end
end
