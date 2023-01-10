# frozen_string_literal: true

module Api
  class ListsController < ApplicationController
    protect_from_forgery with: :null_session
    def index
      @lists = board.lists.order(position: :desc)

      render json: ListSerializer.new(@lists).serializable_hash.to_json
    end

    private

    def board
      @board ||= Board.find(params[:board_id])
    end
  end
end
