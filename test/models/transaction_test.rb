require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  test "it can be marked as finalized" do
    transaction = transactions(:pending)
    user = transaction.user
    expected = user.balance - transaction.amount

    transaction.finalize!

    assert_equal expected, user.balance
  end
end
