class PmPostsController < ApplicationController
  before_action :ensure_logged_in
  before_action :ensure_valid_user

  def create
    @pm_post = pm_topic.pm_posts.build(pm_post_params)
    if @pm_post.save
      pm_topic.update_attributes(last_posted: @pm_post.created_at)
      @pm_post.update_attributes(ip_address: request.remote_ip,
                                 user_id:    current_user.id)
      pm_topic.update_attributes(user_handshake => true) if handshake_sent
      redirect_to pm_topic_path(pm_topic.id, anchor: anchor_for(@pm_post))
    else
      @pm_topic = pm_topic
      @pm_posts = pm_topic.pm_posts.order(created_at: :asc)
      @user_handshake = user_handshake.to_s
      @user_sent_handshake = pm_topic.send(user_handshake)
      render 'pm_topics/show'
    end
  end

  private

    def pm_post_params
      params.require(:pm_post).permit(:pm_topic_id, :content, :handshake_sent)
    end

    def pm_topic
      PmTopic.find_by(id: pm_post_params[:pm_topic_id])
    end

    def ensure_valid_user
      redirect_to root_url unless pm_topic.valid_users.include?(current_user.id)
    end

    def handshake_sent
      pm_post_params[:handshake_sent]
    end

    def user_handshake
      if pm_topic.sender_id == current_user.id
        :sender_handshake
      elsif pm_topic.recipient_id = current_user.id
        :recipient_handshake
      end
    end
end
