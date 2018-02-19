# frozen_string_literal: true

class AddCountryToDetails < ActiveRecord::Migration[5.1]
  def change
    add_column :details, :country, :string
  end
end
