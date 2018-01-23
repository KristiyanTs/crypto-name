Braintree.client = Braintree::Gateway.new(
  environment: env && env.to_sym,
  merchant_id: ENV['BRAINTREE_MERCHANT_ID'],
  public_key: ENV['BRAINTREE_PUBLIC_KEY'],
  private_key: ENV['BRAINTREE_PRIVATE_KEY']
)
