# frozen_string_literal: true

class Price
  attr_reader :price

  def initialize(price)
    @price = price
  end

  def call
    ((price + commission).to_f / 100).ceil * 100 - 11 # $5 = 500
  end

  private

  def commission
    ((price / 500 + 1) * 500) * 30 / 100
  end
end
