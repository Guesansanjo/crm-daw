# frozen_string_literal: true

class BoardUsersController < ApplicationController
  before_action :authenticate_user!

  # GET /board.json

  def new
    @should_render_header = true
    @board_user = board.board_users.new
  end

  def create
    board_user_ids = board.members.where.not(id: board.user_id).ids
    user_ids_to_destroy = board_user_ids - user_ids

    BoardUser.where(board:, user_id: user_ids_to_destroy).delete_all
    users_to_assign = User.where(id: user_ids).where.not(id: board.reload.members.ids)
    board.members << users_to_assign
    flash[:notice] = "User assigned successfully"
    redirect_to board_path(board)
  end

  private

  def user_ids
    params[:user_ids].map(&:to_i).reject(&:zero?)
  end

  def board
    @board ||= Board.find(params[:board_id])
  end
end
