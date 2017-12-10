class CreateDomains < ActiveRecord::Migration[5.1]
  def change
    create_table :domains do |t|
      t.string     :name, null: false
      t.integer    :status, default: 0, null: false

      t.references :users, index: true, null: false
      t.timestamps
    end
  end
end
