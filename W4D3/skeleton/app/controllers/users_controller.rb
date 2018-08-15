class UsersController < ApplicationController
  # def new
  #   render :new
  # end
  before_action :redirect_if_logged_in, only: [:new, :create]

  def create
    user = User.new(user_params)

    if user.save
      login!(user)
      redirect_to cats_url
    else
      flash.now[:errors] = user.errors.full_messages
      # redirect_to new_user_url
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
