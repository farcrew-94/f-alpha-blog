class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #Not that everthing that we make here..can appear to all the other controller and view because all our controler are subclasses of this ApplicationController
  #using helper_method to recognize it for helpers
  helper_method :current_user, :logged_in?

  def current_user
    #memoization
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  #method that has '?' is for boolean
  def logged_in?
    !!current_user #return true or false if current_user is exist
  end

  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end

end
