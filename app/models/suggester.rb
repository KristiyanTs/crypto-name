class Suggester
  KEY = 'domain'.freeze

  def initialize(query)
    @query = query
  end

  def call
    raise 'Could not fetch' unless response.body.present?
    results = response.body.map { |h| h[KEY] }
    available(results)
  end

  def response
    @r ||= GoDaddy.suggest(@query)
  end

  def available(names)
    GoDaddy.available?(names)
  end
end
