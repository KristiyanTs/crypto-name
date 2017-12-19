class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.decimal :amount, precision: 10, scale: 2, null: false

      t.integer :item_id, null: false
      t.string  :item_type, null: false

      t.timestamps
    end

    add_index :transactions, [:item_type, :item_id]
  end
end
