class UsersController < ApplicationController

  def index
    @users = User.all
    render :index
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user
      render :show
    else
      flash[:errors] = ["Invalid User ID"]
      redirect_to users_url
    end
  end

  def new
    render :new
  end

  def create
    user = User.new(user_params)
    if user.save
      login(user)
      redirect_to user_url(user)
    else
      flash.now[:errors] = user.errors.full_messages
      render :new
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
    if @user
      render :edit
    else
      redirect_to users_url
    end
  end

  def update
    user = User.find_by(id: params[:id])
    if user.update(user_params)
      redirect_to user_url(user)
    else
      flash.now[:errors] = user.errors.full_messages
      render :edit
    end
  end

  def destroy
    user = User.find_by(id: params[:id])
    user.destroy
    redirect_to users_url
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end

end
