require 'resolv'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :cache_ip
  before_action :forbid_blacklisted, only: [:create, :update, :destroy]
  before_action :flash_queue
  helper_method :topic_path_for, :page_for

  def topic_path_for(post)
    anchor = 'p' + post.id.to_s
    topic = Topic.find_by(id: post.topic_id)
    topic_path(topic, page: page_for(topic, post), anchor: anchor)
  end

  def page_for(topic, post)
    page = 1
    posts = topic.posts.inject([]) {|acc,p| acc << p.id}
    post_index = posts.index(post.id.to_i)
    until post_index < 20
      post_index -= 20
      page += 1
    end
    page
  end

  protected

    def captcha_verified(model)
      msg  = "There was a problem with your captcha verification - "
      msg += "Please try again"
      verify_recaptcha(model: model, message: msg, error: nil) || logged_in?
    end

    def ensure_logged_in
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def ensure_admin
      redirect_to root_url unless admin_user
    end

  private

    def cache_ip
      unless session[:ip_cached]
        if cached_ip.nil?
          hostname = Resolv.getname(request.remote_ip)
          new_cache = IpCache.new(ip_address: request.remote_ip,
                                  hostname:   hostname)
          new_cache.save!
        else
          forbid_blacklisted
        end
        session[:ip_cached] = true
      end
    end

    def forbid_blacklisted
      Rack::Attack.blacklist("block #{request.remote_ip}") do |req|
        cached_ip.blacklisted
      end
      head :service_unavailable if cached_ip.blacklisted
    end

    def flash_queue
      num_flagged = Post.where(flagged: true).count
      if admin_user && flash.empty? && num_flagged > 0
        are = num_flagged == 1 ? 'is' : 'are'
        flagged_posts = view_context.pluralize(num_flagged, 'flagged post')
        msg  = "There #{are} #{flagged_posts} "
        msg += "waiting in the queue for moderation."
        flash.now[:danger] = view_context.link_to(msg, queue_path)
      end
    end
end
