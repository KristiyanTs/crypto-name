class PaymentCallback
  cattr_accessor :password
  attr_reader :request, :params

  def initialize(request, params)
    @request = request
    @params = params
  end

  def finish!
    validate!

    status = params[:status].to_i
    handle(status)
  rescue => e
    # report error
    # payment failed
  end

  private

  def handle(status)
    return paid if status == 1 || status >= 100
  end

  def paid
    transaction.buy!
  end

  def pending
    transaction.update notes: 'Payment Pending'
  end

  def mispaid
    transaction.update notes: 'Transaction failed, contact support', status: :failed
  end

  def validate!
    raise 'Request must be given' unless request.present?
    raise 'HMAC headers not set' unless hmac.present?
    raise 'Invalid Signature' unless hmac == digest

    raise 'Cannot find Transaction' unless transaction.present?
    raise 'Cannot find User' unless user.present?
  end

  def digest
    OpenSSL::HMAC.hexdigest('sha512', password, request.raw_post)
  end

  def hmac
    request.headers['HTTP_HMAC']
  end

  def transaction
    @transaction ||= Transaction.find(params[:item_number].to_i)
  end

  def user
    @user ||= transaction.user
  end

  def self.call(request:, params:)
    new(request, params).finish!
  end
end
