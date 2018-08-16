class UsersController < ApplicationController

  #Form to create new user (Found in view, users/new.html.erb)
  def new

  end

  #Create the new user
  def create
    user = User.new(user_params)
    if user.save
      login!(user)
      redirect_to user_url(user)
    else
      flash.now[:errors] = user.errors.full_messages
      #will change url, but I get to maintain the data I already inputted on the form
      render :new
    end
  end

  #Show a specific user
  def show
    #Use the id wildcard in the url to find the user
    @user = User.find_by(id: params[:id])
    if @user
      render :show
      #if invalid wildcard :id
    else
      render json: "Come on amigo, this is not a valid user"
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end


end
