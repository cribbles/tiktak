class TopicsController < ApplicationController

  def index
    @topics = Topic.paginate(page: params[:page], per_page: 20)
  end

  def show
    @topic = Topic.find_by(id: params[:id])
    @posts = @topic.posts.paginate(page: params[:page], per_page: 20)
  end

  def new
    @topic = Topic.new
    @topic.posts.build
  end

  def create
    @topic = Topic.new(topic_params)
    if @topic.save
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
      params.require(:topic).permit(:title, posts_attributes: [:content])
    end
end
