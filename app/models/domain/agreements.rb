class Domain::Agreements
  attr_reader :domain

  def initialize(domain)
    @domain = domain
  end

  def call
    response = GoDaddy.get_domain_agreements(tld, domain.privacy)
    raise 'Could not get agreements keys' unless response.success?
    response.body
  end

  private

  def name
    domain.name
  end

  def tld
    name.split('.').last
  end
end
