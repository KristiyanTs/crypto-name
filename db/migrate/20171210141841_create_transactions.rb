# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.references :user, index: true, null: false
      t.string :notes
      t.json   :info
      t.string :remote_checkout
      t.string :remote_id, null: false
      t.string :crypto_currency
      t.string :crypto_address
      t.decimal :crypto_amount, precision: 8, scale: 2
      t.decimal :amount, precision: 8, scale: 2

      t.integer :status

      t.references :item, polymorphic: true, index: true, null: false

      t.timestamps
    end
  end
end
