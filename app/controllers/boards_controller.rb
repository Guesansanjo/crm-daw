# frozen_string_literal: true

class BoardsController < ApplicationController
  before_action :authenticate_user!

  # GET /board.json

  def new
    @should_render_header = true
    @board = Board.new
  end

  def edit
    @should_render_header = true
    authorize board
  end

  def show
    @should_render_header = true
    authorize board
  end

  def create
    @board = Board.new(board_params.merge(user: current_user))

    if @board.save
      flash[:notice] = "Board created successfully"
      redirect_to root_path
    
    else
      render :new
    end
  end

  def update
    authorize board

    if board.update(board_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    authorize board

    board.destroy
    flash[:alert] = "Board deleted successfully"
    redirect_to root_path
  end

  private

  def board_params
    params.require(:board).permit(:name)
  end

  def board
    @board ||= Board.find(params[:id])
  end
end
