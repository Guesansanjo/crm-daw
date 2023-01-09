# frozen_string_literal: true

class RemoveClassListFromLists < ActiveRecord::Migration[7.0]
  def change
    remove_column :lists, :class_list
  end
end
