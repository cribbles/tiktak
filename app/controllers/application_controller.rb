class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception
  before_action :cache_ip
  before_action :forbid_blacklisted, only: [:create, :update, :destroy]
  before_action :check_for_flagged_posts
  helper_method :cached_ip, :hellbanned?

  protected

  def ensure_logged_in
    if !logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def ensure_admin
    redirect_to root_url unless admin_user?
  end

  def captcha_verified(model)
    if logged_in? || Rails.env.test?
      true
    else
      msg  = "There was a problem with your captcha verification - "
      msg += "Please try again"

      verify_recaptcha(model: model, message: msg, error: nil)
    end
  end

  def send_email(mail_type, options = {})
    UserMailer.send(mail_type, options).deliver_now
  end

  def cached_ip
    IpCache.find_by(ip_address: request.remote_ip)
  end

  def hellbanned?
    cached_ip.hellbanned
  end

  def blacklisted?
    cached_ip.blacklisted
  end

  private

  def cache_ip
    if cached_ip.nil?
      new_cache = IpCache.new(ip_address: request.remote_ip,
                              user_agent: request.user_agent,
                              referrer:   request.env["HTTP_REFERER"])
      new_cache.save!
    end
  end

  def forbid_blacklisted
    Rack::Attack.blacklist("block #{request.remote_ip}") { blacklisted? }

    head :service_unavaiable if blacklisted?
  end

  def num_flagged_posts
    Post.where(flagged: true).count
  end

  def check_for_flagged_posts
    flash_queue if admin_user? && flash.empty? && num_flagged_posts > 0
  end

  def flash_queue
    are = (num_flagged_posts == 1 ? "is" : "are")
    flagged_posts = view_context.pluralize(num_flagged_posts, "flagged post")

    msg  = "There #{are} #{flagged_posts} "
    msg += "waiting in the queue for moderation."

    flash.now[:danger] = view_context.link_to(msg, queue_path)
  end
end
