# frozen_string_literal: true

class CreateVats < ActiveRecord::Migration[5.1]
  def change
    create_table :vats, &:timestamps
  end
end
