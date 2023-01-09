# frozen_string_literal: true

class ListsController < ApplicationController
  before_action :authenticate_user!

  def new
    @should_render_header = true
    @list = board.lists.new
  end

  def create
    @list = board.lists.new(list_params)

    if @list.save
      redirect_to board_path(board)
    else
      render :new
    end
  end

  def edit
    @should_render_header = true
    @list = board.lists.find(params[:id])
  end

  private

  def board
    @board ||= Board.find(params[:board_id])
  end

  def list_params
    params.require(:list).permit(:title)
  end
end
