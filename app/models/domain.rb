class Domain < ApplicationRecord
  belongs_to :user
  has_many :transactions, as: :item
  #TODO: validate domain name

  def buy!
    update(status: :complete)
    #TODO: Buy domain from GoDaddy
  end

  def pricing!
    @price ||= GoDaddy.available?(name).body['domains']
  end
end
