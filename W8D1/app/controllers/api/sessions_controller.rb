class Api::SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if @user
      login(@user)
      render "/api/users/show"
    else
      render json: ["Invalid Username/Password Combination"], status: 404
    end
  end

  def destroy
    if current_user
      logout
      return {}
    else
      render json: ["no user has logged in"], status: 404
    end
  end

end
