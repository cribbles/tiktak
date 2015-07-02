class TopicsController < ApplicationController
  before_action :ensure_admin,       only: :destroy
  before_action :ensure_exists,      only: [:show, :destroy]
  before_action :ensure_displayable, only: :show

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
    topic.update_attributes(views: topic.views+1)
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
      update_each(@topic, post, user_id: current_user.id) if logged_in?
      update_each(@topic, post, hellbanned: true) if hellbanned?
      redirect_to @topic
    else
      render 'new'
    end
  end

  def destroy
    topic.update_attributes(visible: false)
    topic.posts.each do |post|
      post.update_attributes(visible: false, flagged: false)
    end
    flash[:danger] = "Topic #{topic.id} was successfully removed."
    redirect_to request.referrer || root_url
  end

  private

    def topic_params
      params.require(:topic).permit(:title,
                                    posts_attributes: [:content, :contact])
    end

    def topic
      Topic.find_by(id: params[:id])
    end

    def ensure_exists
      redirect_to root_url unless topic
    end

    def ensure_displayable
      conditions = [!topic.visible,
                    topic.hellbanned && !hellbanned?]
      redirect_to root_url if conditions.any?
    end

    def update_each(*rows, params)
      rows.each {|r| r.update_attributes(params)}
    end

    def displayable
      where_params = { visible: true }
      where_params.merge!( hellbanned: false ) unless hellbanned?
      where_params
    end

    def order
      last_posted = hellbanned? ? :last_posted_hb : :last_posted
      { last_posted => :desc }
    end
end
