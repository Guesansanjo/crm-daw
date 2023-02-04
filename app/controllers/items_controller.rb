# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :authenticate_user!

  protect_from_forgery with: :null_session, only: :destroy

  def new
    @should_render_header = true
    @item = list.items.new
  end

  def create
    @item = list.items.new(item_params)

    if @item.save
      flash[:notice] = "Item created successfully"
      redirect_to board_path(list.board)
    else
      render :new
    end
  end

  def edit
    @should_render_header = true
    @item = list.items.find(params[:id])
  end

  def update
    @item = list.items.find(params[:id])

    if @item.update(item_params)
      flash[:notice] = "Item updated successfully"
      redirect_to board_path(list.board)
    else
      render :edit
    end
  end

  def destroy
    @item = list.items.find(params[:id])
    flash[:alert] = "Item destroyed successfully"
    @item.destroy

    respond_to do |format|
      format.json do
        render json: {}, status: 200
      end
    end
  end

  private

  def list
    @list ||= List.find(params[:list_id])
  end

  def item_params
    params.require(:item).permit(:title, :description)
  end
end
