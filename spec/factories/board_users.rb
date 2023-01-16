# frozen_string_literal: true

FactoryBot.define do
  factory :board_user do
    board
    user
  end
end
