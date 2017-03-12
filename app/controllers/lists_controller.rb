class ListsController < ApplicationController
  
  before_action :validate_user

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
    # UPDATE PARAMS SO I CAN CREATE A STRONG PARAMS AND FIX SO WHEN I EDIT MY LIST I CAN SELECT AND IT REMEMBERS WHO I HAVE VIEWABLE
    @list = List.find(params[:id])
    @list.update(list_params)
    # @list.viewable_to(params[:list][:user_id])
    redirect_to user_list_path(current_user.id, @list.id)
  end

  def show
    @list = List.find(params[:id])
    unless @list.user == current_user || @list.viewers.include?(current_user)
      # refactor
      redirect_to home_path
      flash.alert = "You are not shared on this list."
    end
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
    params.require(:list).permit(:title, :list_type, viewer_ids:[])
  end
end
