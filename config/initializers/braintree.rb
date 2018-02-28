# frozen_string_literal: true

Rails.configuration.to_prepare do
  
  Braintree::Configuration.environment = Rails.env.production? ? :production : :sandbox
  Braintree::Configuration.logger = Logger.new('log/braintree.log')
  Braintree::Configuration.merchant_id = ENV['BRAINTREE_MERCHANT_ID']
  Braintree::Configuration.public_key = ENV['BRAINTREE_PUBLIC_KEY']
  Braintree::Configuration.private_key = ENV['BRAINTREE_PRIVATE_KEY']
  
  ChargeUser.client = Braintree::Gateway.new(
    environment: Rails.env.production? ? :production : :sandbox,
    merchant_id: ENV['BRAINTREE_MERCHANT_ID'],
    public_key: ENV['BRAINTREE_PUBLIC_KEY'],
    private_key: ENV['BRAINTREE_PRIVATE_KEY']
  )
end
