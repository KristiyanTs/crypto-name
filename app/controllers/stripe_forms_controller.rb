class StripeFormsController < ApplicationController
  def show
    @name = params[:name]
    @price = params[:price].to_i / 10_000
  end
end
