class PmPostsController < ApplicationController
  before_action :ensure_logged_in
  before_action :ensure_valid_user

  def new
    @pm_topic = PmTopic.find_by(id: params[:pm_topic_id])
    @pm_posts = @pm_topic.pm_posts.order(created_at: :asc)
    @pm_post  = @pm_topic.pm_posts.build
    @topic    = Topic.find_by(id: @pm_topic.topic_id)
    @post     = Post.find_by(id: @pm_topic.post_id)
    @title    = 'Re: ' + @topic.title
  end

  def create
    @pm_topic = PmTopic.find_by(id: pm_post_params[:pm_topic_id])
    @pm_post  = @pm_topic.pm_posts.build(pm_post_params)
    @topic    = Topic.find_by(id: @pm_topic.topic_id)
    @post     = Post.find_by(id: @pm_topic.post_id)
    if @pm_topic.save
      @pm_post.update_attributes(ip_address: request.remote_ip,
                                 user_id:    current_user.id)
      if pm_post_params[:handshake]
        case current_user.id
        when @pm_topic.sender_id
          @pm_post.update_attributes(sender_handshake: true)
        when @pm_topic.recipient_id
          @pm_post.update_attributes(recipient_handshake: true)
        end
      end
      redirect_to new_pm_post_path(@pm_topic.id, anchor: "p" + @pm_post.id.to_s)
    else
      render 'new'
    end
  end

  private

    def pm_post_params
      params.require(:pm_post).permit(:pm_topic_id, :content, :handshake)
    end

    def ensure_logged_in
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def ensure_valid_user
      pm_topic_id = params[:pm_topic_id] || pm_post_params[:pm_topic_id]
      pm_topic = PmTopic.find_by(id: pm_topic_id)
      valid_users = [pm_topic.sender_id, pm_topic.recipient_id]
      redirect_to root_url unless valid_users.include?(current_user.id)
    end
end
