class ChargeUser
  def self.charge(user:, amount:, description: "Charge for #{user.email}")
    Stripe::Charge.create(
      customer: user.customer_id,
      amount: amount,
      description: description,
      currency: 'usd'
    )
  end

  def self.create_customer(email:, token:)
    Stripe::Customer.create(
      email: email,
      source: token
    ).id
  end
end
