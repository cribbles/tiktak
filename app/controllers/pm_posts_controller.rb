class PmPostsController < ApplicationController
  before_action :ensure_logged_in
  before_action :ensure_valid_user

  def create
    @pm_topic = PmTopic.find_by(id: pm_post_params[:pm_topic_id])
    @pm_post  = @pm_topic.pm_posts.build(pm_post_params)
    if @pm_post.save
      @pm_topic.update_attributes(last_posted: @pm_post.created_at)
      @pm_post.update_attributes(ip_address: request.remote_ip,
                                 user_id:    current_user.id)
      @pm_topic.update_attributes(user_handshake => true) if handshake_sent
      redirect_to pm_topic_path(@pm_topic.id, anchor: "p" + @pm_post.id.to_s)
    else
      render 'new'
    end
  end

  private

    def pm_post_params
      params.require(:pm_post).permit(:pm_topic_id, :content, :handshake_sent)
    end

    def ensure_logged_in
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def ensure_valid_user
      pm_topic = PmTopic.find_by(id: pm_post_params[:pm_topic_id])
      redirect_to root_url unless pm_topic.valid_users.include?(current_user.id)
    end

    def user_handshake
      pm_topic = PmTopic.find_by(id: params[:pm_topic_id])
      return case current_user.id
      when pm_topic.sender_id
        :sender_handshake
      when pm_topic.recipient_id
        :recipient_handshake
      end
    end

    def handshake_sent
      pm_post_params[:handshake_sent]
    end
end