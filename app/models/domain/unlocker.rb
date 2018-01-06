class Domain
  class Unlocker
    attr_reader :domain

    def initialize(domain)
      @domain = domain
    end

    def call
      response = GoDaddy.update_domain(domain.name, { locked: false })

      raise 'Could not unlock domain, try again later!' unless response.success?
    end
  end
end
