class Item < ApplicationRecord
  belongs_to :cart


  after_save do
    calculate_prices
    cart.calculate_prices
  end

  after_destroy do
    cart.calculate_prices
  end

  private 

  def calculate_prices
    case action
    when 'buy'
      case entity
      when 'domain'
        domain = Domain.new(name: info)
        self.update_columns(price_per_duration: domain.pricing!) if price_per_duration.nil?
        self.update_columns(price_total: price_per_duration * duration)
      else
      end
    else
    end
  end
end
