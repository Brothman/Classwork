require 'json'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    @req = req
    # debugger
    unless req.cookies.empty?
      @session_cookie = eval(req.cookies["_rails_lite_app"])
    else
      @session_cookie = {}
    end
  end

  def [](key)
    # debugger
    @session_cookie[key.to_sym]
  end

  def []=(key, val)
    @session_cookie[key.to_sym] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    json_session_cookie = @session_cookie.to_json
    res.set_cookie("_rails_lite_app", path: "/", value: json_session_cookie)
  end
end
