# frozen_string_literal: true

class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :items

  def calculate_subtotal
    update_columns(subtotal: items.sum('price_total'))
  end

  def calculate_total
    calculate_subtotal
    (subtotal + fees) * (1 + Vat.new(user.detail.country).call)
  end

  private

  def fees
    items.where(entity: 'domain').count * 18
  end
end
