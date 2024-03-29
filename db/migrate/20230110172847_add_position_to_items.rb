# frozen_string_literal: true

class AddPositionToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :position, :integer, null: false, default: 0
  end
end
