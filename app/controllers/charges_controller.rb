class ChargesController < ApplicationController
  before_action :validate_purchase, only: :create

  def create
    current_user.domains.create!(domain_params)
    customer = ChargeUser.create_customer(email: params[:stripeEmail], token: params[:stripeToekn])
    current_user.update!(customer_id: customer)
    BuyDomainJob.perform_later(domain)

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

  def validate_purchase
    raise 'Stripe missing email.' unless params[:stripeEmail].present?
    raise 'Stripe missing token.' unless params[:stripeToken].present?
  end
end
