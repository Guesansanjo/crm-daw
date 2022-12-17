# frozen_string_literal: true

class BoardsController < ApplicationController
  before_action :authenticate_user!

  def new
    @board = Board.new
  end

  def edit
    @board = Board.find(params[:id])
    authorize @board
  end

  def create
    @board = Board.new(board_params.merge(user: current_user))

    if @board.save
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    @board = Board.find(params[:id])

    if @board.update(board_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def board_params
    params.require(:board).permit(:name)
  end
end
