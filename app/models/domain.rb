class Domain < ApplicationRecord
  belongs_to :user
  has_many :transactions, as: :item
  #TODO: validate domain name

  def buy!
    update(status: :complete)
    #TODO: Buy domain from GoDaddy
  end

  def pricing!
    #TODO: when resellers, this is fixed instead of fetching it.
    @price ||= (GoDaddy.available?(name)&.body['price'] / 10000)
  end
end
