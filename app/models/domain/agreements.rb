# frozen_string_literal: true

class Domain::Agreements
  attr_reader :domain

  def initialize(domain)
    @domain = domain
  end

  def call
    response = GoDaddy.get_domain_agreements(tld, true)
    raise 'Could not get agreements keys' unless response.success?
    response.body
  end

  private

  def tld
    domain.tld
  end
end
