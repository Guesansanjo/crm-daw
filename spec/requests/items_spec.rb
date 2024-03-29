# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Items', type: :request do
  let(:user) { create(:user) }
  let(:board) { create(:board, user:) }
  let(:list) { create(:list, board:) }
  let(:item) { create(:item, list:) }
  before do
    sign_in user
  end

  describe 'GET new' do
    it 'succeeds' do
      get new_list_item_path(list)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET edit' do
    it 'succeeds' do
      get edit_list_item_path(list, item)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST create' do
    context 'with valid params' do
      it 'creates a new list and redirects' do
        expect do
          post list_items_path(list), params: {
            item: {
              title: 'New List',
              description: 'prueba'
            }
          }
        end.to change { Item.count }.by(1)
        expect(response).to have_http_status(:redirect)
      end
    end
    context 'with invalid params' do
      it 'does not create a new board and renders new' do
        expect do
          post list_items_path(list), params: {
            item: {
              title: '',
              description: ''
            }
          }
        end.not_to change { Item.count }
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'PUT update' do
    context 'with valid params' do
      it 'updates the board and redirects' do
        expect do
          put list_item_path(list, item), params: {
            item: {
              title: 'Updated List'
            }
          }
        end.to change { item.reload.title }.to('Updated List')
        expect(response).to have_http_status(:redirect)
      end
    end
    context 'with invalid params' do
      it 'does not updates the board and renders edit' do
        expect do
          put list_item_path(list, item), params: {
            item: {
              title: ''
            }
          }
        end.not_to change { item.reload.title }
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the list record ' do
      list
      expect do
        delete board_list_path(board, list), headers: { 'ACCEPT': 'application/json' }
      end.to change { List.count }.by(-1)
      expect(response).to have_http_status(:success)
    end
  end
end
