class Braintree
  cattr_accessor :client

  def self.token
    client.client_token.generate
  end
end
