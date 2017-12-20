class Suggester
  KEY = 'domain'.freeze

  def initialize(query)
    @query = query
  end

  def call
    raise 'Could not fetch' unless response.body.present?
    raise 'Retry' unless available.body['domains']
    available.body['domains'].select do |domain|
      domain['available']
    end
  end

  def response
    @r ||= GoDaddy.suggest(@query)
  end

  def suggested
    @suggested ||= response.body.map { |h| h[KEY] }
  end

  def available
    @available ||= GoDaddy.available?(*suggested)
  end
end
