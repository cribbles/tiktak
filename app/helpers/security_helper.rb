require 'open-uri'

module SecurityHelper
  def proxy_check
    ip = request.remote_ip
    Rack::Attack.blacklist("block #{ip}") do |req|
      proxy = open("http://www.shroomery.org/ythan/proxycheck.php?ip=#{ip}")
      proxy == 'Y'
    end
  end
end
