class Domain::Buyer
  attr_reader :domain

  def initialize(domain)
    @domain = domain
  end

  def call
    GoDaddy.purchase(
      {
        domain: domain.name,
        period: domain.duration,
        renewAuto: domain.renewal,
        privacy: domain.privacy,
        consent: {
          agreementKeys: domain.agreement_keys,
          agreedBy: user.last_sign_in_ip,
          agreedOn: user.confirmed_at
        },
        contactRegistrant: detail,
        contantBilling: Detail::Null::GoDaddy.to_details
      }
    )
  end

  private

  def user
    @user ||= domain.user
  end

  def detail
    @detail ||= user.active_details.to_details
  end
end
