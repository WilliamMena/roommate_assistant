class SessionsController < ApplicationController

  def welcome
    if signed_in?
      redirect_to home_path
    else
      render :welcome
    end
  end


end
