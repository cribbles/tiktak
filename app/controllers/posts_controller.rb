class PostsController < ApplicationController

  def show
    @post = Post.find_by(id: params[:id])
    @topic = Topic.find_by(id: @post.topic_id)
  end

  def new
    @topic = Topic.find_by(id: params[:topic_id])
    @post = @topic.posts.build
  end

  def create
    @topic = Topic.find_by(id: post_params[:topic_id])
    @post = @topic.posts.build(post_params)
    if @post.save
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

    def post_params
      params.require(:post).permit(:topic_id, :content)
    end
end
