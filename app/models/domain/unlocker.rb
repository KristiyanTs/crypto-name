class Domain
  class Unlocker
    attr_reader :domain

    def initialize(domain)
      @domain = domain
    end

    def call
      GoDaddy.update_domain(domain.name, { locked: false })
    end
  end
end
