class ChargesController < ApplicationController
  before_action :validate_purchase, only: :create

  def create
    @items = client_cart.items

    @items.each do |item|
      domain = current_user.domains.create!(domain_params)
      customer = ChargeUser.create_customer(
        email: params[:stripeEmail],
        token: params[:stripeToken]
      )
      current_user.update!(customer_id: customer)
      Domain::BuyJob.perform_later(domain)
    end

    redirect_to domains_path, notice: 'We have begun processing your domain. Please, review the default settings!'
  rescue => e
    redirect_to domains_path, notice: "Payment failed with: #{e.message}. Try again later..."
  end

  private

  def amount
    domain.pricing!
  end

  # TODO: this is only item
  def domain_params
    params.require(:domain).permit(:name, :duration)
  end

  def validate_purchase
    raise 'Stripe missing email.' unless params[:stripeEmail].present?
    raise 'Stripe missing token.' unless params[:stripeToken].present?
  end
end
