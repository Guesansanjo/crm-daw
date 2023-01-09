# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Boards', type: :request do
  let(:user) { create(:user) }
  let(:board) { create(:board, user:) }
  let(:list) { create(:list, board:) }
  before do
    sign_in user
  end

  describe 'GET new' do
    it 'succeeds' do
      get new_board_list_path(board)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET edit' do
    it 'succeeds' do
      get edit_board_list_path(board, list)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST create' do
    context 'with valid params' do
      it 'creates a new list and redirects' do
        expect do
          post board_lists_path(board), params: {
            list: {
              title: 'New List'
            }
          }
        end.to change { List.count }.by(1)
        expect(response).to have_http_status(:redirect)
      end
    end
    context 'with invalid params' do
      it 'does not create a new board and renders new' do
        expect do
          post board_lists_path(board), params: {
            list: {
              title: ''
            }
          }
        end.not_to change { List.count }
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'PUT update' do
    context 'with valid params' do
      it 'updates the board and redirects' do
        expect do
          put board_list_path(board, list), params: {
            list: {
              title: 'Updated List'
            }
          }
        end.to change { list.reload.title }.to('Updated List')
        expect(response).to have_http_status(:redirect)
      end
    end
    context 'with invalid params' do
      it 'does not updates the board and renders edit' do
        expect do
          put board_list_path(board, list), params: {
            list: {
              title: ''
            }
          }
        end.not_to change { list.reload.title }
        expect(response).to have_http_status(:success)
      end
    end
  end

  pending do
    describe 'DELETE destroy' do
      it 'deletes the board record ' do
        board
        expect do
          delete board_path(board)
        end.to change { Board.count }.by(-1)
        expect(response).to have_http_status(:redirect)
      end
    end
  end
end
