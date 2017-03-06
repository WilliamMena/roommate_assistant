class UsersController < ApplicationController
  def home
    @lists = current_user.lists
  end

  def index
    @users = User.all
    # @users.delete_if {|a| (actual_roommates+current_user).include?(a)}
  end

  def roommates
    @users = current_user.actual_roommates
  end
end
