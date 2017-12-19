class Domain < ApplicationRecord
  belongs_to :user
  has_many :transactions, as: :item

  def buy!
    update(status: :complete)
    #TODO: Buy domain from GoDaddy
  end
end
