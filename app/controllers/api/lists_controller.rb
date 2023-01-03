module Api
    class ListsController < ApplicationController
        def index
            @lists = List.all

            render json: ListSerializer.new(@lists).serializable_hash.to_json
        end
    end

    private

    def board
        @board ||= Board.find(params[:board_id])
    end
        
end