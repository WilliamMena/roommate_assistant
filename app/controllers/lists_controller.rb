class ListsController < ApplicationController
  
  def new
    @list = List.new
  end

  def edit
    @list = List.new
  end

  def show
    @list = List.find(params[:id])
  end
end
