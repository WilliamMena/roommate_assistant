class UsersController < ApplicationController
  def home
    @lists = current_user.lists
  end

  def index
    @users = User.all
    # @users.delete_if {|a| (actual_roommates+current_user).include?(a)}
  end

  def roommates
    if !current_user.actual_roommates.empty?
      @users = current_user.actual_roommates
    else
      redirect_to users_path
    end
  end

end
