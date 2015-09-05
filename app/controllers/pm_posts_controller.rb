class PmPostsController < ApplicationController
  include PmLibrary

  before_action :ensure_pm_topic_exists
  before_action :ensure_valid_user

  def create
    @pm_post = pm_topic.pm_posts.build(pm_post_params)

    if @pm_post.save
      pm_topic.update_attributes(user_handshake => true) if handshake_sent?
      pm_topic.update_attributes(last_posted: @pm_post.created_at,
                                 correspondent_unread => true)
      @pm_post.update_attributes(ip_address: request.remote_ip,
                                 user_id:    current_user.id)

      redirect_to pm_topic_path(pm_topic.id, anchor: @pm_post.anchor)
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

  def handshake_sent?
    pm_post_params[:handshake_sent]
  end
end
