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
  end

  def create
    @topic = Topic.new(title: topic_params[:title])
    @post = Post.new(topic_id: @topic.id, content: topic_params[:context])
    if @topic.save && @post.save
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
      params.require(:topic).permit(:title)
    end

    def post_params
      params.require(:topic).require(:post).permit(:content)
    end
end
