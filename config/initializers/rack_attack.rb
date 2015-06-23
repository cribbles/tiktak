class Rack::Attack
  throttle('req/ip', :limit => 300, :period => 5.minutes) do |req|
    req.ip
  end

  throttle('logins/ip', :limit => 5, :period => 20.seconds) do |req|
    if req.path == '/login' && req.post?
      req.ip
    end
  end

  standard_fail = lambda {[503, {}, ['503: Service Unavailable']]}

  throttled_response   = standard_fail.call
  blacklisted_response = standard_fail.call
end
