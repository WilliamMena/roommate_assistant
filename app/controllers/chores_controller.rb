class ChoresController < ApplicationController

  def create
    list = List.find(params[:list_id])
    list.chores.build(name: params[:chore], user_id: params[:user][:user_id])
    list.save
    redirect_to user_list_path(list.user.id, list.id)
  end

  def edit
    @chore = Chore.find(params[:id])
  end

  def update
    chore = Chore.find(params[:id])
    chore.update(chore_params)
    chore.save
    redirect_to user_list_path(current_user.id, chore.list.id)
  end

  def complete
    chore = Chore.find(params[:id])
    chore.update(completed: true)
    redirect_to user_list_path(chore.list.user.id, chore.list.id)
  end

  def incomplete
    chore = Chore.find(params[:id])
    chore.update(completed: false)
    redirect_to user_list_path(chore.list.user.id, chore.list.id)
  end

  def destroy
    chore = Chore.find(params[:id])
    if chore.list.user == current_user
      chore.destroy
      flash.alert = "Chore Deleted"
    else
      flash.alert = "You did not create this list"
    end
    redirect_to user_list_path(chore.list.user.id, chore.list.id)
  end




  def chore_params
    params.require(:chore).permit(:name, :user_id)
  end

end
