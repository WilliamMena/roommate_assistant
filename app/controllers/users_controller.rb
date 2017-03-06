class UsersController < ApplicationController
  def home
    @lists = current_user.lists
  end

  def index
    @users = User.all.to_a
    @users.delete_if {|u| u == current_user }
  end

end
