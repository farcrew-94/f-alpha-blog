class PagesController < ApplicationController

  def home
    redirect_to articles_path if logged_in? #if the user logged_in then redirect_to articles_path, else juz go to home that is root path
  end

  def about
  end

end
