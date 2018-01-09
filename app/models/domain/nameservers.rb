class Domain
  class Nameservers
    attr_reader :domain, :nameservers

    def initialize(domain, nameservers)
      @domain = domain
      @nameservers = nameservers
    end

    def call
      response = GoDaddy.update_domain(domain.name, { nameServers: nameserver })

      raise 'Could not update nameservers of domain, try again later!' unless response.success?
    end
  end
end
