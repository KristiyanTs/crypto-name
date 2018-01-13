class CreateRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :records do |t|
      t.integer :type, null: false
      t.string :name, limit: 255, null: false
      t.string :value, limit: 255, null: false
      t.integer :ttl, null: false
      t.integer :priority

      t.string :service
      t.string :protocol
      t.integer :port
      t.integer :weight

      t.references :domain, index: true, null: false

      t.timestamps
    end
  end
end
