# frozen_string_literal: true

class List < ApplicationRecord
  belongs_to :board

  has_many :items, dependent: :destroy

  validates :title, presence: true
end
