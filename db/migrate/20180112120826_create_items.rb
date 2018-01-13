class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.references :cart, index: true, null: false
      t.string :title
      t.string :info
      t.string :action,                null: false
      t.string :entity,                null: false
      t.integer :price_total
      t.integer :price_per_duration
      t.integer :duration

      t.timestamps
    end
  end
end
