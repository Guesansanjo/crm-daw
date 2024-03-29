# frozen_string_literal: true

class CreateItemMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :item_members do |t|
      t.references :item, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
