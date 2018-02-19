# frozen_string_literal: true

class Domain
  class Nameservers
    attr_reader :domain, :nameservers

    def initialize(domain)
      @domain = domain
    end

    def call
      response = GoDaddy.update_domain(domain.name,  nameServers: api_nameserver)

      raise 'Could not update nameservers of domain, try again later!' unless response.success?

      domain.update!(nameservers: nameservers)
    end

    private

    def api_nameservers
      nameservers.map { |n| { n.name => n.ip_addresses } }
    end
  end
end
