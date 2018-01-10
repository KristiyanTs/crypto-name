class Domain < ApplicationRecord
  include Domain::RemoteHelpers

  belongs_to :user

  has_many :nameservers
  has_many :records
  has_many :transactions, as: :item

  accepts_nested_attributes_for :nameservers
  accepts_nested_attributes_for :records
  # TODO: validate domain name

  enum status: { pending: 0, complete: 1, failed: 2 }

  def buy!
    Domain::Buyer.new(self).call
    update(status: :complete)
  rescue StandardError
    update(status: :failed) # :'(
  end

  def pricing!
    # TODO: when resellers, this is fixed instead of fetching it.
    @price ||= begin
                 remote_price = GoDaddy.available?(name).body['price']
                 normalized = remote_price / 10_000
                 floating = normalized.to_f / 100
                 price = Price.new(floating).call
                 SpecialPrice.new(price, tld).call
               end
  end

  def agreements
    @agreements ||= Domain::Agreements.new(self).call
  end

  def agreement_keys
    agreements.map { |agreement| agreement['agreementKey'] }
  end

  def agreement_keys!
    @agreements = nil
    agreement_keys
  end

  def tld
    name.split('.').drop(1).join('.')
  end
end
