class PaymentCallbackController < ApplicationController
  def update
    PaymentCallback.call(body: params, request: request)
  end
end
