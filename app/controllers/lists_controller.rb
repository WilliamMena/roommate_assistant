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
  end

  def update
    @list = List.find(params[:id])
    @list.update(list_params)
    redirect_to user_list_path(current_user.id, @list.id)
  end

  def show
    @list = List.find(params[:id])
  end



  private

  def list_params
    params.require(:list).permit(:title)
  end
end
