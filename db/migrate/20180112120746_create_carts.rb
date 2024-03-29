# frozen_string_literal: true

class CreateCarts < ActiveRecord::Migration[5.1]
  def change
    create_table :carts do |t|
      t.references :user, index: true
      t.integer :subtotal
      t.integer :total

      t.timestamps
    end
  end
end
