class StripeFormsController < ApplicationController
  def show
    @name = params[:name]
    @price = params[:total_price]
  end
end
