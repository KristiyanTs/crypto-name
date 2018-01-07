class SpecialPrice
  attr_reader :tld, :price
  def initialize(price, tld)
    @price = price
    @tld = tld
  end

  def call
    if tld == 'com' 
      price - 2
    else
      price
    end
  end
end
