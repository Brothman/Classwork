class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :logged_in?

  def login!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logout!(user)
    user.reset_session_token!
    session[:session_token] = nil
  end

  #Unsure why I need booleans instead of truthy and falsy values, will ask in class
  def logged_in?
    if current_user
      true
    else
      false
    end
  end


end
