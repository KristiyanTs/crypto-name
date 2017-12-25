class PaymentsController < ApplicationController
  def new
    CreateCoinpaymentsTopup.call(
      user: context.user,
      amount: context.amount,
      minimum_topup: context.user.minimum_topup,
      callback_url: Rails.application.routes.url_helpers.coinpayments_callback_url(secret: '123', protocol: 'https'),
      crypto_currency: context.currency
    )
  end

  def update
    PaymentCallback.call(body: params, request: request)
  end
end
