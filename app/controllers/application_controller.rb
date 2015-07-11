class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :cache_ip
  before_action :forbid_blacklisted, only: [:create, :update, :destroy]
  before_action :check_for_flagged_posts

  protected

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

    def captcha_verified(model)
      return true if logged_in? || Rails.env.test?

      msg  = 'There was a problem with your captcha verification - '
      msg += 'Please try again'

      verify_recaptcha(model: model, message: msg, error: nil)
    end

    def update_each(*rows, &params)
      rows.each { |row| row.update_attributes(params.call) }
    end

    def send_email(mail_type, options = {})
      UserMailer.send(mail_type, options).deliver_now
    end

  private

    def cache_ip
      unless session[:ip_cached]
        if cached_ip.nil?
          new_cache = IpCache.new(ip_address: request.remote_ip,
                                  user_agent: request.user_agent,
                                  referrer:   request.env['HTTP_REFERER'])
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

    def check_for_flagged_posts
      @num_flagged = Post.where(flagged: true).count

      flash_queue if admin_user && flash.empty? && @num_flagged > 0
    end

    def flash_queue
      are = @num_flagged == 1 ? 'is' : 'are'
      flagged_posts = view_context.pluralize(@num_flagged, 'flagged post')

      msg  = "There #{are} #{flagged_posts} "
      msg += "waiting in the queue for moderation."

      flash.now[:danger] = view_context.link_to(msg, queue_path)
    end
end
