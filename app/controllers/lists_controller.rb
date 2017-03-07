class ListsController < ApplicationController
  
  def new
    @list = List.new
  end

  def edit
    @list = List.find(params[:id])
  end

  def create
    @list = current_user.lists.build(list_params)
    @list.save
    redirect_to user_list_path(current_user.id, @list.id)
    flash.alert = "New List created"
  end

  def update
    @list = List.find(params[:id])
    @list.update(list_params)
    redirect_to user_list_path(current_user.id, @list.id)
  end

  def show
    @list = List.find(params[:id])
  end

  def destroy
    @list = List.find(params[:id])
    if @list.user == current_user
      @list.destroy
      redirect_to home_path
      flash.alert = "Successfully Deleted List"
    else
      redirect_to list_path(@list)
      flash.alert = "You don't own this list"
    end
  end



  private

  def list_params
    params.require(:list).permit(:title)
  end
end
