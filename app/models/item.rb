# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :cart

  after_save do
    calculate_prices
    cart.calculate_subtotal
  end

  after_destroy do
    cart.calculate_subtotal
  end

  private

  def calculate_prices
    case action
    when 'buy'
      case entity
      when 'domain'
        domain = Domain.new(name: info)
        update_columns(price_per_duration: domain.pricing!) if price_per_duration.nil?
        update_columns(price_total: price_per_duration * duration)
      end
    end
  end
end
