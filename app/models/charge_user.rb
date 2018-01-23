class ChargeUser
  def self.charge(user:, amount:, description: "Charge for #{user.email}")
    Braintree.client.transaction.sale(
      amount: amount,
      payment_method_nonce: user,
    )
  end
end
