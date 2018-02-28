# frozen_string_literal: true

BraintreeRails::Configuration.environment = Rails.env.production? ? :production : :sandbox
BraintreeRails::Configuration.logger = Logger.new('log/braintree.log')
BraintreeRails::Configuration.merchant_id = ENV['BRAINTREE_MERCHANT_ID']
BraintreeRails::Configuration.public_key = ENV['BRAINTREE_PUBLIC_KEY']
BraintreeRails::Configuration.private_key = ENV['BRAINTREE_PRIVATE_KEY']

Rails.configuration.to_prepare do
  ChargeUser.client = Braintree::Gateway.new(
    environment: Rails.env.production? ? :production : :sandbox,
    merchant_id: ENV['BRAINTREE_MERCHANT_ID'],
    public_key: ENV['BRAINTREE_PUBLIC_KEY'],
    private_key: ENV['BRAINTREE_PRIVATE_KEY']
  )
end
