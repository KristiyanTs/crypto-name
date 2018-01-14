class Domain::BuyJob < ApplicationJob
  def perform(domain, charge)
    @domain = domain
    id, charge_info = charge

    user.transactions.create!(
      remote_id: id,
      info: charge_info,
      notes: "Domain #{domain.name} for #{user.email}.",
      item: domain
    )
    domain.buy!
  end

  private

  def user
    @user ||= @domain.user
  end
end
