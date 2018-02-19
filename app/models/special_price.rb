# frozen_string_literal: true

class SpecialPrice
  attr_reader :tld, :price
  def initialize(price, tld)
    @price = price
    @tld = tld
  end

  def call
    case tld
    when 'com'
      price * 0.8
    when 'net'
      price * 0.8
    else
      price
    end
  end
end
