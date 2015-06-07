class PmTopicsController < ApplicationController
  before_action :ensure_logged_in
  before_action :ensure_distinct_users

  def new
    @pm_topic = PmTopic.new
    @pm_topic.pm_posts.build
    @topic = Topic.find_by(id: params[:topic_id])
    @post  = Post.find_by(id: params[:post_id])
    @title = 'Re: ' + @topic.title
  end

  def create
    @pm_topic = PmTopic.new(pm_topic_params)
    @post  = Post.find_by(id: pm_topic_params[:post_id])
    if @pm_topic.save
      @pm_topic.update_attributes(sender_id:    current_user.id,
                                  recipient_id: @post.user_id)
#                                 sender_handshake: pm_topic_params[:handshake])
      @pm_post = @pm_topic.pm_posts.first
      @pm_post.update_attributes(user_id: current_user.id,
                                 ip_address: request.remote_ip)
      redirect_to new_pm_post_path(@pm_topic, anchor: "p" + @pm_post.id.to_s)
    else
      render 'new'
    end
  end

  private

    def pm_topic_params
      params.require(:pm_topic).permit(:topic_id, :post_id,
                                pm_posts_attributes: [:content])
    end

    def ensure_logged_in
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def ensure_distinct_users
      post_id = params[:post_id] || pm_topic_params[:post_id]
      recipient_id = Post.find_by(id: post_id).user_id
      if recipient_id == current_user.id
        flash[:warning] = "You can't send yourself a private message!"
        redirect_to :back
      end
    end
end
