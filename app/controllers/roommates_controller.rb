class RoommatesController < ApplicationController

  before_action :validate_user

  def create
    current_user.roommates.find_or_create_by(roommate_id: params[:roommate_id])
    if current_user.actual_roommates.include?(User.find(params[:roommate_id]))
      redirect_to home_path
      flash.notice = "Successfully added roommate"
    else
      redirect_to users_path
      flash.alert = "Requested Roommate"
    end
  end

  def destroy #destroy's the roommate relationship, then redirects to roommates page.
    roommate = User.find(params[:id])
    if current_user.actual_roommates.include?(roommate)
      Roommate.remove(current_user, roommate)
      redirect_to roommates_path
    else
      flash.alert = "This isn't your roommate"
      redirect_to root_path
    end
  end

  def index
    if !current_user.actual_roommates.empty?
      @users = current_user.actual_roommates
    else
      redirect_to users_path
    end
  end

end
