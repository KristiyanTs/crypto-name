# frozen_string_literal: true

class Consent
  attr_reader :user, :domain

  def initialize(user, domain)
    @user = user
    @domain = domain
  end

  def call
    {
      'agreementKeys' => domain.agreement_keys[0..0],
      'agreedBy'      => user.last_sign_in_ip,
      'agreedAt'      => user.confirmed_at.iso8601
    }
  end
end
