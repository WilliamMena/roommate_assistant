class GroceryItemsController < ApplicationController

  def create
    grocery = Grocery.create(name: params[:item])
    list = List.find(params[:list_id])
    list.groceries << grocery
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
