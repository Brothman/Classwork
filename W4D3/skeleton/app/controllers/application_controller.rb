class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    user = User.find_by(session_token: session[:session_token])
    user
  end

  def logout!(user)
    user.reset_session_token!
    user.save!
    session[:session_token] = nil
  end

  def login!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def redirect_if_logged_in
    redirect_to cats_url if current_user
  end

end
