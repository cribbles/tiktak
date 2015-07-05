class PmTopicsController < ApplicationController
  before_action :ensure_logged_in
  before_action :ensure_post_exists,     only: [:new, :create]
  before_action :ensure_contactable,     only: [:new, :create]
  before_action :ensure_distinct_users,  only: [:new, :create]
  before_action :ensure_pm_topic_exists, only: [:show, :update]
  before_action :ensure_valid_user,      only: [:show, :update]
  before_action :mark_as_read,           only: :show

  def index
    @pm_topics = current_user.pm_topics
                             .order(last_posted: :desc)
                             .paginate(page: params[:page], per_page: 10)
  end

  def show
    @pm_topic = pm_topic
    @pm_posts = @pm_topic.pm_posts.order(created_at: :asc)
    @pm_post  = @pm_topic.pm_posts.build
    @user_handshake = user_handshake.to_s
    @user_sent_handshake = @pm_topic.send(user_handshake)
  end

  def new
    @pm_topic = PmTopic.new
    @pm_topic.pm_posts.build
    @topic = topic 
    @post  = post
  end

  def create
    @pm_topic = PmTopic.new(pm_topic_params)
    if @pm_topic.save
      @pm_post = @pm_topic.pm_posts.first
      @pm_post.update_attributes(user_id:    current_user.id,
                                 ip_address: request.remote_ip)
      @pm_topic.update_attributes(sender_id:     current_user.id,
                                  recipient_id:  post.user_id,
                                  last_posted:   @pm_post.created_at,
                                  sender_unread: false)
      @pm_topic.update_attributes(sender_handshake: true) if handshake_sent
      redirect_to @pm_topic
    else
      render 'new'
    end
  end

  def update
    pm_topic.update_attributes(patch_params) unless invalid_patch
    redirect_to pm_topic
  end

  private

    def pm_topic_params
      params.require(:pm_topic)
            .permit(:topic_id, :post_id, :title,
                    pm_posts_attributes: [:content, :handshake_sent])
    end

    def patch_params
      params.require(:pm_topic)
            .permit(:id, :handshake_declined, user_handshake)
    end

    def pm_topic
      id = params[:id] || patch_params[:id]
      PmTopic.find_by(id: id)
    end

    def topic
      id = params[:topic_id] || pm_topic_params[:topic_id]
      Topic.find_by(id: id)
    end

    def post
      id = params[:post_id] || pm_topic_params[:post_id]
      topic.posts.find_by(id: id)
    end

    def ensure_post_exists
      redirect_to root_url if !topic || !post
    end

    def ensure_contactable
      conditions = [!post.contact,
                    !post.visible,
                    post.hellbanned && !hellbanned?] 
      redirect_to root_url if conditions.any?
    end

    def ensure_distinct_users
      if post.user_id == current_user.id
        flash[:warning] = "You can't send yourself a private message!"
        redirect_to :back
      end
    end

    def ensure_pm_topic_exists
      redirect_to root_url unless pm_topic
    end

    def ensure_valid_user
      redirect_to root_url unless pm_topic.valid_users.include?(current_user.id)
    end

    def handshake_sent
      pm_topic_params[:pm_posts_attributes]["0"][:handshake_sent]
    end

    def pm_user
      pm_topic.sender_id == current_user.id ? 'sender' : 'recipient'
    end

    def user_handshake
      "#{pm_user}_handshake".to_sym
    end

    def mark_as_read
      user_unread = "#{pm_user}_unread".to_sym
      pm_topic.update_attributes(user_unread => false)
    end

    def invalid_patch
      handshake = patch_params[user_handshake] || pm_topic.send(user_handshake)
      patch_params[:handshake_declined] && handshake
    end
end
