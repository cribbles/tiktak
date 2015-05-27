class PostsController < ApplicationController

  def show
    @post  = Post.find_by(id: params[:id])
    @topic = Topic.find_by(id: @post.topic_id)
  end

  def new
    @topic = Topic.find_by(id: params[:topic_id])
    @quote = @topic.posts.find_by(id: params[:id])
    @post  = @topic.posts.build
  end

  def create
    @topic = Topic.find_by(id: post_params[:topic_id])
    @post  = @topic.posts.build(post_params)
    if @post.save
      @topic.update_attributes(last_posted: @post.created_at)
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
      params.require(:post).permit(:topic_id, :content, :quote)
    end
end
