require 'resolv'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :call_cache

  private

    def call_cache
      unless session[:user_cached]
        ip_addr    = IPAddr.new(request.remote_ip).to_i
        user_cache = IpCache.find_by(ip_addr: ip_addr)
          if user_cache.nil?
            hostname  = Resolv.getname(request.remote_ip)
            new_cache = IpCache.new(ip_addr: ip_addr, hostname: hostname)
            new_cache.save!
          else
            blacklist(user_cache)
          end
        session[:user_cached] = true
      end
    end

    def blacklist(user)
      ip = request.remote_ip
      Rack::Attack.blacklist("block #{ip}") do |req|
        user.blacklisted
      end
    end
end
