require 'resolv'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :cache_ip
  before_action :forbid_blacklisted, only: [:create, :update, :destroy]

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

    def forbid_blacklisted
      Rack::Attack.blacklist("block #{request.remote_ip}") do |req|
        cached_ip.blacklisted
      end
      head :service_unavailable if cached_ip.blacklisted
    end

    def cache_ip
      unless session[:ip_cached]
        if cached_ip.nil?
          hostname = Resolv.getname(request.remote_ip)
          new_cache = IpCache.new(ip_addr:  formatted_ip,
                                  hostname: hostname)
          new_cache.save!
        else
          forbid_blacklisted
        end
        session[:ip_cached] = true
      end
    end
end
