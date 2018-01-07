class Domain
  class Transfer
    attr_reader :domain, :user, :unlock_code

    def initialize(user, name, unlock_code)
      @user = user
      @domain = user.domains.new(name: name, renewal: true, privacy: true)
      @unlock_code = unlock_code
    end

    def call
      GoDaddy.transfer_domain(
        domain.name,
        {
          authCode: unlock_code,
          renewAuto: true,
          consent: consent
        }
      )
    end

    private

    def consent
      @consent ||= Consent.new(user, domain).call
    end
  end
end
