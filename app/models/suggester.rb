class Suggester
  KEY = 'domain'.freeze

  def initialize(query)
    @query = query
  end

  def call
    raise 'Could not fetch' unless response.body.present?
    raise 'Retry' unless available.body['domains']

    normalized
  end

  private

  def response
    @r ||= GoDaddy.suggest(@query)
  end

  def suggested
    @suggested ||= response.body.map { |h| h[KEY] }
  end

  def normalized
    available.body['domains'].map do |domain|
      price = domain['price'] / 10_000
      price = price.to_f / 100
      price = Price.new(price).call.to_f
      domain['price'] = SpecialPrice.new(price, domain['domain'].split('.').last).call
      domain
    end
  end

  def available
    @available ||= 
      Retrier.attempt(-> (response) { response&.body['domains'].present? },
        tries: 3,
        delay: 0.seconds) { GoDaddy.available?(*suggested) }
  end
end
