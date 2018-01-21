class ChargesController < ApplicationController
  before_action :validate_purchase, only: :create

  def create
    @items = client_cart.items

    customer = ChargeUser.create_customer(
      email: params[:stripeEmail],
      token: params[:stripeToken]
    )
    current_user.update!(customer_id: customer)
    charge = ChargeUser.charge(user: user, amount: client_cart.total)

    @items.where(entity: 'domain').each do |item|
      domain = current_user.domains.create!(name: item.info, duration: item.duration, renewal: false, privacy: false, detail: current_detail)
      Domain::BuyJob.perform_later(domain, [charge[:id], charge.to_json])
    end

    redirect_to domains_path, notice: 'We have begun processing your domain. Please, review the default settings!'
  rescue => e
    redirect_to domains_path, notice: "Payment failed with: #{e.message}. Try again later..."
  end

  private

  def validate_purchase
    raise 'Stripe missing email.' unless params[:stripeEmail].present?
    raise 'Stripe missing token.' unless params[:stripeToken].present?
  end
end
