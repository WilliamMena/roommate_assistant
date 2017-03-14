class SessionsController < ApplicationController

  def welcome
    #welcome page
    if signed_in?
      # Or what ever the signed in home path would be
      redirect_to home_path
    else
      render :welcome
    end
  end


end
