# frozen_string_literal: true

class CreateDomains < ActiveRecord::Migration[5.1]
  def change
    create_table :domains do |t|
      t.string     :name, null: false
      t.integer    :status, default: 0, null: false
      t.integer    :duration, default: 1, null: false
      t.boolean    :renewal, null: false, default: true
      t.boolean    :privacy, null: false, default: false

      t.string     :unlock_code

      t.references :user, index: true, null: false
      t.timestamps
    end
  end
end
