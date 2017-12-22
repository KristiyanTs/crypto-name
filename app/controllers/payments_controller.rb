class PaymentsController < ApplicationController
  def create
    transaction = current_user.transactions.create!(transaction_params.merge(topup))
    Payment.new(transaction).create!
    # redirect_to 'coinpayments'
  rescue => err
    render json: err.message
  end

  def transaction_params
    params.require(:transaction).permit(:amount, :crypto_currency)
  end

  def topup
    {
      status: :pending,
      type: :topup,
      notes: { message: "Topup payment" }
    }
  end
end
