# frozen_string_literal: true

class ChargeUser
  cattr_accessor :client

  def self.charge(nonce:, amount:)
    client.transaction.sale(
      amount: amount,
      payment_method_nonce: nonce
    )
  end

  def self.token
    client.client_token.generate
  end
end
