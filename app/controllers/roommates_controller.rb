class RoommatesController < ApplicationController

  def destroy #destroy's the roommate relationship, then redirects to roommates page.
    # Need to prepare for when a user is not signed in and also for when the requested delete relationship isn't part of the users relationship
    roommate = User.find(params[:id])
    if current_user.actual_roommates.include?(roommate)
      Roommate.remove(current_user, roommate)
      redirect_to roommates_path
    else
      flash.alert = "This isn't your roommate"
      redirect_to root_path
    end
  end

end
