class Domain < ApplicationRecord
  has_one :transaction, as: :item

  def buy!
    update(status: :complete)
    #TODO: Buy domain from GoDaddy
  end
end
