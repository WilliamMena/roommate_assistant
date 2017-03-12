class GroceryItemsController < ApplicationController

  before_action :validate_user

  def create
    list = List.find(params[:list_id])
    list.grocery_items.build(item: params[:item])
    list.save
    redirect_to user_list_path(list.user.id, list.id)
  end

  def buy
    gi = GroceryItem.find(params[:id])
    gi.update(bought: true)
    redirect_to user_list_path(gi.list.user.id, gi.list.id)
  end

  def unbuy
    gi = GroceryItem.find(params[:id])
    gi.update(bought: false)
    redirect_to user_list_path(gi.list.user.id, gi.list.id)
  end



end
