class Transaction < ApplicationRecord
  class LowBalance < StandardError; end

  belongs_to :item, polymorphic: true
  belongs_to :user

  enum status: { pending: 0, complete: 1, failed: 2 }
  enum type: { topup: 0 }

  def finalize!
    user.with_lock do
      raise LowBalance unless user.balance > amount
      user.increment!(:balance, -amount)
      complete!
    end
  end

  def topup!
    user.with_lock do
      user.increment!(:balance, amount)
      update(status: :complete, notes: { message: 'Topup money transacted.'})
    end
  end
end
