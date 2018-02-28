# frozen_string_literal: true

class ChargesController < ApplicationController
  before_action :validate_purchase, only: :create

  def new
    @client_token = ChargeUser.token
    @amount = client_cart.total.to_i / 100.0
  end

  def create
    @items = client_cart.items

    current_user.update!(customer_id: customer)
    charge = ChargeUser.charge(nonce: nonce, amount: client_cart.total)

    @items.where(entity: 'domain').each do |item|
      domain = current_user.domains.create!(name: item.info, duration: item.duration, renewal: false, privacy: false, detail: current_detail)
      Domain::BuyJob.perform_later(domain, [charge[:id], charge.to_json])
    end

    redirect_to domains_path, notice: 'We have begun processing your domain. Please, review the default settings!'
  rescue StandardError => e
    redirect_to domains_path, notice: "Payment failed with: #{e.message}. Try again later..."
  end

  private

  def validate_purchase
    raise 'Invalid payment nonce.' unless params[:payment_method_nonce].present?
  end

  def nonce
    params[:payment_method_nonce]
  end
end
