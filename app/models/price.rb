class Price
  attr_reader :price

  def initialize(price)
    @price = price
  end

  def call
    ((price + taxes + 48).to_f / 100).ceil * 100 - 51 # $5 = 500
  end

  private

  def taxes
    ((price / 500 + 1) * 500) * 15 / 100
  end
end
