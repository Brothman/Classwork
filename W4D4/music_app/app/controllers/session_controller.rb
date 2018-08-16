class SessionController < ApplicationController

  #For showing form to log in
  def new
  end

  #For logging in
  def create
    user = User.find_by_credentials(params[:user][:email], params[:user][:password])
    #If we found a valid user with that email and password,
    #Log in that user, then redirect to the show page for that user
    if user
      login!(user)
      redirect_to user_url(user)
    #Otherwise, go back to the log in page and add an error saying invalid username password combination
    else
      flash.now[:errors] = ["Invalid password and username combination"]
      render :new
    end
  end

  #For logging out
  def destroy
    logout!(current_user)
    redirect_to new_session_url
  end
end
