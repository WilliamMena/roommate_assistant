class GroceryItemsController < ApplicationController

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
