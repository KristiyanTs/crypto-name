# frozen_string_literal: true

class Availability
  def initialize(domain, category)
    @domain = domain
    @category = category.to_i
  end

  def call
    normalized
  end

  private

  def normalized
    available.map do |domain|
      domain['price'] /= 10_000
      domain['price'] = Price.new(domain['price']).call
      domain['price'] = SpecialPrice.new(domain['price'], domain['domain'].split('.').last).call
      domain
    end
  end

  def available
    GoDaddy.available?(*combinations).body['domains'].select { |domain| domain['available'] }
  end

  def combinations
    top_domains.map { |td| "#{@domain}#{td}" }
  end

  def top_domains
    TLDTypes[@category]
  end
end
