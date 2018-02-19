# frozen_string_literal: true

class Domain
  class Transfer
    attr_reader :domain, :user, :unlock_code

    def initialize(user, name, unlock_code, privacy)
      @user = user
      @domain = user.domains.new(name: name, renewal: true, privacy: privacy)
      @unlock_code = unlock_code
    end

    def call
      response = GoDaddy.transfer_domain(
        domain.name,
        authCode: unlock_code,
        privacy: domain.privacy,
        renewAuto: domain.renewal,
        consent: consent
      )

      if response.success?
        domain.save!
      else
        raise 'Could not transfer'
      end
    end

    private

    def consent
      @consent ||= Consent.new(user, domain).call
    end
  end
end
