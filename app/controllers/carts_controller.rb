class CartsController < ApplicationController

  def show
    @detail = current_user.detail || Detail.new
    @price = client_cart.total
  end

end
