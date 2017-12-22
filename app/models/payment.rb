class Payment
  class ParsingError < StandardError; end

  attr_reader :transaction

  # Pending transaction
  def initialize(transaction)
    @transaction = transaction
  end

  def create!
    begin
      payment
      status_key = parse_status_key!
    rescue ParsingError => e
      raise "Payment failed, try again later..."
    end

    transaction.update(
      remote_checkout_id: status_key,
      remote_id: payment[:txn_id],
      crypto_amount: payment[:amount],
      crypto_address: payment[:address],
      crypto_currency: crypto_currency
    )
  end

  private

  def parse_status_key!
    parse_error('Expected correct payment', payment) if bad_payment?

    query = URI.parse(payment.status_url).query
    parse_error('Expected query parameters', query) unless query

    params = CGI.parse(query)
    parse_error('Expected key parameters', params) unless params['key'].is_a? Array

    params['key'].first
  rescue URI::InvalidURIError => err
    parse_error("Expected valid URI #{err.message}", payment)
  end

  def payment
    @payment ||= Coinpayments.create_transaction(
      transaction.amount,
      'USD',
      transaction.crypto_currency,
      item_number: transaction.id,
      buyer_email: transaction.user.email,
      item_name: "Topup Transaction",
      ipn_url: Rails.application.routes.url_helpers.payment_callback_url(secret: PaymentCallback.password, protocol: 'https', id: transaction.id)
)
  end

  def self.accepted_coins
    Coinpayments&.rates(accepted: 1)
                &.reject { |_, v| v['accepted'].zero? }
                &.keys
  end

  private

  def bad_payment?
    return true unless payment.is_a?(Hashie::Mash)
    return true unless payment.status_url?
    return true unless payment.txn_id?
    return true unless payment.amount?
    return true unless payment.address?
    false
  end

  def parse_error(message, reason = nil)
    raise ParsingError, "#{message}, got #{reason.inspect}"
  end
end
