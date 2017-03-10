class UsersController < ApplicationController
  def home
    @lists = current_user.lists
    @pending = current_user.pending_roommates
  end

  def index
    if current_user.nil?
      redirect_to root_path
    else
      @users = User.all.to_a
      @users.delete_if {|u| u == current_user }
    end
  end

end
