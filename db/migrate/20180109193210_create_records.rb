class CreateRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :records do |t|
      t.references :domain, index: true, null: false
     
      t.integer :ttl, default: 3600,     null: false 
      t.string :kind,                   null: false
      t.string :name, limit: 255,        null: false
      t.string :value, limit: 255,       null: false

      t.string :service
      t.string :protocol
      t.integer :port
      t.integer :weight
      t.integer :priority

      t.timestamps
    end
  end
end
