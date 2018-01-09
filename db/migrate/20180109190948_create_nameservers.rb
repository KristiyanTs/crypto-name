class CreateNameservers < ActiveRecord::Migration[5.1]
  def change
    create_table :nameservers do |t|
      t.string :name, null: false
      t.text :ip_addresses, array: true, default: []

      t.references :domains, null: false, index: true
      t.timestamps
    end
  end
end
