class TopicsController < ApplicationController

  def index
    @topics = Topic.order(last_posted: :desc)
                   .paginate(page: params[:page], per_page: 20)
  end

  def show
    @topic = Topic.find_by(id: params[:id])
    @posts = @topic.posts
                   .order(created_at: :asc)
                   .paginate(page: params[:page], per_page: 20)
    @topic.update_attributes(views: @topic.views+1)
  end

  def new
    @topic = Topic.new
    @topic.posts.build
  end

  def create
    @topic = Topic.new(topic_params)
    if captcha_verified(@topic) && @topic.save
      @post = @topic.posts.first
      @topic.update_attributes(last_posted: @post.created_at)
      if logged_in?
        [@topic, @post].each {|t| t.update_attributes(user_id: current_user.id)}
      end
      redirect_to @topic
    else
      render 'new'
    end
  end

  def edit
  end

  def destroy
  end

  private

    def topic_params
      params.require(:topic).permit(:title,
                                    posts_attributes: [:content, :contact])
    end
end
