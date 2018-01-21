class CartsController < ApplicationController
  before_action :login

  def show
    @detail = current_user.detail
    @price = client_cart.total
  end
end
