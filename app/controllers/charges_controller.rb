class ChargesController < ApplicationController
  def create
    charge = Stripe::Charge.create(
      email: current_user.email,
      amount: amount,
      description: "Charge for #{current_user.email}",
      currency: 'usd'
    )

    current_user.transactions.create!(
      info: charge.to_json,
      notes: "Domain #{domain.name} for #{current_user.email}."
      amount: amount
    )
    redirect_to domains_path, notice: 'We have begun processing your domain.'
  rescue => e
    redirect_to root_path, notice: 'Payment failed.'
  end

  private

  def amount
    domain.pricing!
  end

  def domain
    @domain ||= current_user.domains.create!(domain_params)
  end

  # TODO: this is only item
  def domain_params
    params.require(:domain).permit(:name)
  end
end
