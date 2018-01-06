class Domain
  class UnlockCode
    attr_reader :domain

    def initialize(domain)
      @domain = domain
    end

    def call
      response = GoDaddy.get_domain(domain.name)

      raise 'Could not get Auth Code.' unless response.successful?

      domain.update!(auth_code: response.body['domain']['authCode'])
    end
  end
end
