# frozen_string_literal: true

class CreateDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :details do |t|
      t.references :user, index: true
      t.references :domain, index: true
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :organization
      t.string :job_title
      t.string :email, null: false
      t.string :phone, null: false
      t.string :fax
      t.string :address1, null: false
      t.string :address2
      t.string :city, null: false
      t.string :state
      t.string :postal_code
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
