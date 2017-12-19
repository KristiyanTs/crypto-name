class Payment
  class ParsingError < StandardError; end

  attr_reader :user, :amount, :currency

  def initialize(user, amount, currency)
    @user = user
    @amount = amount
    @currency = currency
  end

  def create!
    transaction = user.transactions.create!(
      amount: amount,
      status: 0,
      crypto_currency: crypto_currency
    )

    begin
      status_key = parse_status_key!
    rescue ParsingError => e
      # TODO: Handle Error
      # transaction_error!
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

  def transaction_error!
    transaction.failed!
  end

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
    return @payment if @payment
    @payment = self.class.create(transaction: transaction,
                                crypto_currency: crypto_currency,
                                amount: amount
    )
  end

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

  def self.accepted_coins
    Coinpayments&.rates(accepted: 1)
                &.reject { |_, v| v['accepted'].zero? }
                &.keys
  end

  def self.create(transaction:, crypto_currency:, amount:)
    Coinpayments.create_transaction amount, 'USD', crypto_currency,
      item_number: transaction.id,
      buyer_email: transaction.user.email,
      item_name: "Transaction for Domain",
      ipn_url: Rails.application.routes.url_helpers.coinpayments_callback_url(secret: 'asdf', protocol: 'https')
  end
end
