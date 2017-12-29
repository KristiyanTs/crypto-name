class ChargesController < ApplicationController
  def create
    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )

    current_user.update!(customer_id: customer.id)

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: amount,
      description: "Charge for #{current_user.email}",
      currency: 'usd'
    )

    current_user.transactions.create!(
      remote_id: charge[:id],
      info: charge.to_json,
      notes: "Domain #{domain.name} for #{current_user.email}.",
      amount: amount,
      item: domain
    )

    redirect_to domains_path, notice: 'We have begun processing your domain.'
  rescue => e
    redirect_to domains_path, notice: "Payment failed with: #{e.message}. Try again later..."
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
    params.require(:domain).permit(:name, :duration)
  end
end
