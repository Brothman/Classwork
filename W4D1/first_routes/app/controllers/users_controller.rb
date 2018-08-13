class UsersController < ApplicationController

  def index
    if params[:query]
      users = User.where("users.username ILIKE '%#{params[:query]}%'")
      if users
        render json: users
      else
        render json: 'no matching user found'
      end
    else
      users = User.all
      render json: users
    end
  end

  def show
    user = User.find_by(id: params[:id])
    if user
      render json: user
    else
      render json: 'no user here :('
    end
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: user
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    user = User.find_by(id: params[:id])

    unless user
      render json: 'There aint no user here'
      return
    end

    if user.update(user_params)
      render json: user
    else
      render json: user.errors.full_messages, status: 422
    end

  end

  def destroy
    user = User.find_by(id: user_params[:id])

    if user
      user.destroy
      render json: user
    else
      render json: 'There aint no user here'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end

end
