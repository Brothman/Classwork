class SessionsController < ApplicationController

  before_action :redirect_if_logged_in, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by_credentials(params[:user][:username], params[:user][:password])

    if user
      login!(user)
      redirect_to cats_url
    else
      flash.now[:errors] = ['Invalid password and username combination']
      render :new
    end
  end

  def destroy
    logout!(current_user) if current_user
    redirect_to new_session_url
  end

end
