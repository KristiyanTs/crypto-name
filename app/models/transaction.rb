class Transaction < ApplicationRecord
  belongs_to :item, polymorphic: true
  belongs_to :user

  enum status: { pending: 0, complete: 1, failed: 2 }

  def finalize!
    user.with_lock do
      user.increment!(:balance, -amount)
      complete! && save
    end
  end
end
