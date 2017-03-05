class UsersController < ApplicationController
  def home
    @lists = current_user.lists
  end

  def index
    @users = User.all
  end

  def roommates
    @users = current_user.actual_roommates
  end
end
