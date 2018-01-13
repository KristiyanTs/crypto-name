class Consent
  attr_reader :user, :domain
  
  def initialize(user, domain)
    @user = user
    @domain = domain
  end

  def call
    {
      'agreementKeys' => ['DNRA'],   #replace with domain.agreement_keys after making sure the payment information is correct
      'agreedBy'      => user.last_sign_in_ip,
      'agreedAt'      => user.confirmed_at.iso8601
    }
  end
end
