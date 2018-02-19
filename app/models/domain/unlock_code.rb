# frozen_string_literal: true

class Domain
  class UnlockCode
    attr_reader :domain

    def initialize(domain)
      @domain = domain
    end

    def call
      return unlock_code unless unlock_code.blank?

      response = GoDaddy.get_domain(domain.name)

      raise 'Could not get Auth Code.' unless response.successful?

      domain.update!(unlock_code: response.body['domain']['authCode'])
      unlock_code
    end

    private

    def unlock_code
      domain.unlock_code
    end
  end
end
