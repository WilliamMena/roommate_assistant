class UsersController < ApplicationController
  def home
    @lists = current_user.lists
  end

  def index
    @users = User.all
  end

end
