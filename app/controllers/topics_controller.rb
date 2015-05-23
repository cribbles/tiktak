class TopicsController < ApplicationController

  def create
  end

  def destroy
  end

  def show
    @topic = Topic.find_by(id: params[:id])
    @posts = @topic.posts.paginate(page: params[:page], per_page: 20)
  end

  def index
    @topics = Topic.paginate(page: params[:page], per_page: 20)
  end
end
