# frozen_string_literal: true

class ListsController < ApplicationController
  before_action :authenticate_user!

  protect_from_forgery with: :null_session, only: :destroy

  def new
    @should_render_header = true
    @list = board.lists.new
  end

  def create
    @list = board.lists.new(list_params)

    if @list.save
      flash[:notice] = "List created successfully"
      redirect_to board_path(board)
    else
      render :new
    end
  end

  def edit
    @should_render_header = true
    @list = board.lists.find(params[:id])
  end

  def update
    @list = board.lists.find(params[:id])

    if @list.update(list_params)
      flash[:notice] = "List updated successfully"
      redirect_to board_path(board)
    else
      render :edit
    end
  end

  def destroy
    @list = board.lists.find(params[:id])
    flash[:alert] = "List deleted successfully"
    @list.destroy

    respond_to do |format|
      format.json do
        render json: {}, status: 200
      end
    end
  end

  private

  def board
    @board ||= Board.find(params[:board_id])
  end

  def list_params
    params.require(:list).permit(:title)
  end
end
