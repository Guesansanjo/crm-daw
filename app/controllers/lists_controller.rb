# frozen_string_literal: true

class ListsController < ApplicationController
    before_action :authenticate_user!

    def new
        @should_render_header = true
        @list = board.lists.new
    end

    private 

    def board
        @board ||= Board.find(params[:board_id])
    end
end