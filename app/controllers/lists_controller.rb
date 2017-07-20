class ListsController < ApplicationController

  before_action :validate_user

  def index
    @lists = current_user.lists

    respond_to do |f|
      f.html { render :index }
      f.json { render json: @lists}
    end
  end

  def shared
    @lists = current_user.viewable_lists

    respond_to do |f|
      f.html { render :index }
      f.json { render json: @lists }
    end
  end


  def new
    @list = List.new
    @list.chores.build
    @list.grocery_items.build
  end

  def edit
    @list = List.find(params[:id])
  end

  def create
    # "chores_attributes"=>{"0"=>{"name"=>"zsdcxz", "user_id"=>"9"}}}
    @list = current_user.lists.build(list_params.except!(:grocery_items_attributes, :chores_attributes))
    @list.item_attributes=(list_params)

    if !@list.errors.full_messages.empty?
      redirect_to new_list_path
      flash.alert = @list.errors.full_messages[0]
    elsif @list.save
      redirect_to user_list_path(current_user.id, @list.id)
      flash.alert = "New List created"
    else
      redirect_to new_list_path
      flash.alert = @list.errors.full_messages[0]
    end
  end

  def update
    @list = List.find(params[:id])
    @list.update(list_params)
    redirect_to user_list_path(current_user.id, @list.id)
  end

  def show
    @list = List.find(params[:id])
    respond_to do |f|
      f.html { render :show }
      f.json { render json: @list}
    end
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
    params.require(:list).permit(:title, :list_type, viewer_ids:[], grocery_items_attributes: [:item], chores_attributes: [:name, :user_id])
  end
end
