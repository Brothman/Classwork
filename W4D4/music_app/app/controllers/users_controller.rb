class UsersController < ApplicationController

  #Form to create new user (Found in view, users/new.html.erb)
  def new

  end

  #Create the new user
  def create

  end

  #Show a specific user
  def show
    #Use the id wildcard in the url to find the user
    @user = User.find(params[:id])
    if user

      #if invalid wildcard :id
    else
      render json: "Come on amigo, this is not a valid user"
    end
  end


end
