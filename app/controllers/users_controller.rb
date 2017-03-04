class UsersController < ApplicationController
  def home
    @lists = current_user.lists
  end
end
