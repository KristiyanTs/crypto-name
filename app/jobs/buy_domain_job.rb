class BuyDomainJob < ApplicationJob
  def perform(domain)
    @doman = domain

    charge = ChargeUser.charge(user: user, amount: domain.pricing!)
    user.transactions.create!(
      remote_id: charge[:id],
      info: charge.to_json,
      notes: "Domain #{domain.name} for #{user.email}.",
      amount: amount,
      item: domain
    )
    domain.buy!
  end

  private

  def user
    @user ||= @domain.user
  end
end
