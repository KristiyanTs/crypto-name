# frozen_string_literal: true

Rails.configuration.to_prepare do
  
  ChargeUser.client = Braintree::Gateway.new(
    environment: Rails.env.production? ? :production : :sandbox,
    merchant_id: ENV['BRAINTREE_MERCHANT_ID'],
    public_key: ENV['BRAINTREE_PUBLIC_KEY'],
    private_key: ENV['BRAINTREE_PRIVATE_KEY']
  )
end
