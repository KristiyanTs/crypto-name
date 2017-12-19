class Transaction < ApplicationRecord
  class LowBalance < StandardError; end

  belongs_to :item, polymorphic: true
  belongs_to :user

  enum status: { pending: 0, complete: 1, failed: 2 }

  def finalize!
    user.with_lock do
      raise LowBalance unless user.balance > amount
      user.increment(:balance, -amount)
      user.save!
      complete!
    end
  end
end
