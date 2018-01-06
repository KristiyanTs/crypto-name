class Consent
  def initialize(user, domain)
    @user = user
    @domain = domain
  end

  def call
    {
      agreementKeys: domain.agreement_keys,
      agreedBy: user.last_sign_in_ip,
      agreedOn: user.confirmed_at
    }
  end
end
