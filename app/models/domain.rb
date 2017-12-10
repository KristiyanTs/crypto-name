class Domain < ApplicationRecord
  enum status: { pending: 0, complete: 1, failed: 2 }

  def buy!
    update(status: :complete)
    #TODO: Buy domain from GoDaddy
  end
end
