class ApplicationController < ActionController::Base

  helper_method :current_user

  def login(user)

  end

  def current_user
    User.last
  end
end
