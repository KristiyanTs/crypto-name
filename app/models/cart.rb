class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :items

  def calculate_prices
    update_columns(subtotal: items.sum('price_total'))
    update_columns(total: subtotal + fees)
  end

  def fees
    0
  end
end
