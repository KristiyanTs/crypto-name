class AddDomainToDetails < ActiveRecord::Migration[5.1]
  def change
    add_reference :details, :domain, foreign_key: true
  end
end
