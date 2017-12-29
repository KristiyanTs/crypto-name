class Domain::BuyJob < ApplicationJob
  def perform(domain)
    @domain = domain

    byebug
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
