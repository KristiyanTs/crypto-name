require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  test "it can be marked as finalized" do
    transaction = transactions(:pending)
    user = transaction.user
    expected = user.balance - transaction.amount

    transaction.finalize!

    assert_equal expected, user.balance
    assert transaction.complete?
  end

  test "it raises an error if balance lower than transaction" do
    transaction = transactions(:pending)
    user = transaction.user
    user.update(balance: 0)

    assert_raises {
      transaction.finalize!
    }
  end
end
