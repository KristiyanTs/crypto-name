class Domain < ApplicationRecord
  belongs_to :user
  has_many :transactions, as: :item
  #TODO: validate domain name

  enum status: { pending: 0, complete: 1, failed: 2 }

  def buy!
    Domain::Buyer.new(self).call
    update(status: :complete)
  rescue => e
    update(status: :failed) # :'(
  end

  def pricing!
    #TODO: when resellers, this is fixed instead of fetching it.
    @price ||= (GoDaddy.available?(name)&.body['price'] / 10000)
  end

  def agreements
    @agreements ||= Domain::Agreements.new(self).call
  end

  def agreement_keys
    agreements.map { |agreement| agreement['agreementKeys'] }
  end
end
