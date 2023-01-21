# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Board, type: :model do
  it { should belong_to :user }
  it { is_expected.to belong_to :user }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to have_many(:lists).dependent(:destroy) }
  it { is_expected.to have_many(:board_users).dependent(:destroy) }
  it { is_expected.to have_many(:members).through(:board_users).source(:user) }

  describe '#assign_user_as_member' do
    it 'assigns creator as member ' do
      user = create(:user)
      board = create(:board, user:)
      expect(board.members).to include(user)
    end
  end
end
