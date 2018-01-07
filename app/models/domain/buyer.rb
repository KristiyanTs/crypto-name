require_dependency 'detail/null/go_daddy'

class Domain::Buyer
  attr_reader :domain

  def initialize(domain)
    @domain = domain
  end

  def call
    GoDaddy.purchase(
      domain: domain.name,
      period: domain.duration,
      renewAuto: domain.renewal,
      privacy: domain.privacy,
      consent: consent,
      nameServers: [],
      contactRegistrant: detail,
      contactAdmin: Detail::Null::GoDaddy.to_details,
      contactBilling: Detail::Null::GoDaddy.to_details,
      contactTech: Detail::Null::GoDaddy.to_details
    )
  end

  private

  def user
    @user ||= domain.user
  end

  def detail
    @detail ||= user.active_details.to_details
  end

  def consent
    @consent ||= Consent.new(user, domain).call
  end
end
