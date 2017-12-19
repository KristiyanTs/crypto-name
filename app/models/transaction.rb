class Transaction < ApplicationRecord
  belongs_to :item, polymorphic: true

  enum status: { pending: 0, complete: 1, failed: 2 }
end
