class SessionsController < ApplicationController

  def new

  end

  def create
    #not using instance varibale because we are not going to pass
    user = User.find_by(email: params[:session][:email].downcase) #find user using email that he/she enter...downcase because at database we are using downcase
    #if user is valid and authenticate password using hash is correct...then...
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id #store in cookies session
      flash[:success] = "You have successfully logged in"
      redirect_to user_path(user)
    else
      #flash.now means...flash it at the same page not redirect page like others
      flash.now[:danger] = "There was something wrong with your login information!"
      render 'new'
    end
  end

  def destroy
    #make session id = nil
    session[:user_id] = nil
    flash[:success] = "You have logged out!"
    redirect_to root_path
  end

end
