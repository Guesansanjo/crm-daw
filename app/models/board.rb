# frozen_string_literal: true

class Board < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
end
