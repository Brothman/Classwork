class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if @user && @user.save
      login!(@user)
      redirect_to subs_url
    else
      flash.now[:errors] = ['Incorrect username and/or password.']
      @user ||= User.new(username: params[:user][:username])
      render :new
    end
  end

  def destroy
    logout!
  end
end
