class Suggester
  KEY = 'domain'.freeze

  def initialize(query)
    @query = query
  end

  def call
    raise 'Could not fetch' unless response.body.present?
    raise 'Retry' unless available.body['domains']

    available.body['domains']
  end

  def response
    @r ||= GoDaddy.suggest(@query)
  end

  def suggested
    @suggested ||= response.body.map { |h| h[KEY] }
  end

  def available
    @available ||= 
      Retrier.attempt(-> (response) { response&.body['domains'].present? },
        tries: 3,
        delay: 0.seconds) { GoDaddy.available?(*suggested) }
  end
end
