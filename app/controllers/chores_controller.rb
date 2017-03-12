class ChoresController < ApplicationController

  def create
    list = List.find(params[:list_id])
    list.chores.build(name: params[:chore], user_id: params[:user][:user_id])
    list.save
    redirect_to user_list_path(list.user.id, list.id)
  end


end
