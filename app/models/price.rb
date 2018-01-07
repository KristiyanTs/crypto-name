class Price
  attr_reader :price

  def initialize(price)
    @price = price
  end

  def call
    (price + taxes + 0.48).to_i
  end

  private

  def taxes
    ((price.to_i / 5 + 1) * 5).to_f * 15 / 100
  end
end
