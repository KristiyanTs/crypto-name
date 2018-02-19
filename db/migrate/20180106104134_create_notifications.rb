# frozen_string_literal: true

class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.references :user, index: true, null: false
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
