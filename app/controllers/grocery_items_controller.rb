class GroceryItemsController < ApplicationController

  before_action :validate_user

  def create
    list = List.find(params[:list_id])
    list.grocery_items.build(grocery_params)
    list.save
    render :json => {:status => :ok}
    # redirect_to user_list_path(list.user.id, list.id)
  end

  def edit
    @grocery_item = GroceryItem.find(params[:id])
  end

  def update
    grocery_item = GroceryItem.find(params[:id])
    grocery_item.update(grocery_params)
    grocery_item.save
    # when not using ajax, uncomment
    redirect_to user_list_path(grocery_item.list.user.id, grocery_item.list.id)
  end

  def buy
    gi = GroceryItem.find(params[:id])
    gi.update(bought: true)
    render :json => {:status => :ok}
    # redirect_to user_list_path(gi.list.user.id, gi.list.id)
  end

  def unbuy
    gi = GroceryItem.find(params[:id])
    gi.update(bought: false)
    render :json => {:status => :ok}
    # redirect_to user_list_path(gi.list.user.id, gi.list.id)
  end

  def destroy
    gi = GroceryItem.find(params[:id])
    gi.destroy
    redirect_to user_list_path(gi.list.user.id, gi.list.id)
    flash.alert = "Grocery Deleted"
  end

  def grocery_params
    params.require(:grocery_item).permit(:item, :bought)
  end


end
