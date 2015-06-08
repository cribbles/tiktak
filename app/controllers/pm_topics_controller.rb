class PmTopicsController < ApplicationController
  before_action :ensure_logged_in
  before_action :ensure_topic_post_associated, only: [:new, :create]
  before_action :ensure_contact,               only: [:new, :create]
  before_action :ensure_distinct_users,        only: [:new, :create]

  def index
    @pm_topics = current_user.pm_topics
                             .order(last_posted: :desc)
                             .paginate(page: params[:page], per_page: 10)
  end

  def new
    @pm_topic = PmTopic.new
    @pm_topic.pm_posts.build
    @topic = Topic.find_by(id: params[:topic_id])
    @post  = Post.find_by(id: params[:post_id])
    @title = 'Re: ' + @topic.title
  end

  def create
    handshake = pm_topic_params.delete(:handshake)
    @post = Post.find_by(id: pm_topic_params[:post_id])
    @pm_topic = PmTopic.new(pm_topic_params)
    if @pm_topic.save
      @pm_post = @pm_topic.pm_posts.first
      @pm_post.update_attributes(user_id:    current_user.id,
                                 ip_address: request.remote_ip)
      @pm_topic.update_attributes(sender_id:        current_user.id,
                                  recipient_id:     @post.user_id,
                                  last_posted:      @pm_post.created_at,
                                  sender_handshake: handshake)
      redirect_to new_pm_topic_post_path(@pm_topic)
    else
      render 'new'
    end
  end

  private

    def pm_topic_params
      params.require(:pm_topic).permit(:topic_id, :post_id, #:handshake,
                                pm_posts_attributes: :content)
    end

    def ensure_logged_in
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def ensure_topic_post_associated
      topic_id = params[:topic_id] || pm_topic_params[:topic_id]
      post_id  = params[:post_id]  || pm_topic_params[:post_id]
      topic_id_from_query = Post.find_by(id: post_id).topic_id
      redirect_to root_url unless topic_id_from_query == topic_id.to_i
    end

    def ensure_contact
      post_id = params[:post_id] || pm_topic_params[:post_id]
      redirect_to root_url unless Post.find_by(id: post_id).contact
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
