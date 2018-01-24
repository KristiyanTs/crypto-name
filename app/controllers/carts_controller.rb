class CartsController < ApplicationController
  before_action :login

  def show
    @right_wrapper = 'details/info'
    @detail = current_user.detail || Detail.new
    @price = client_cart.total
  end

end
