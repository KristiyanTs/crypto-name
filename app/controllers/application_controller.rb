class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :client_cart
  before_action { flash.clear }
  before_action :set_right_wrapper

  # TODO: action helper
  def login
    redirect_to new_user_session_path unless current_user.present?
  end

  def client_cart
    if session[:cart_id] && Cart.exists?(session[:cart_id])
      Cart.find(session[:cart_id])
    else
      cart = user_signed_in? ? current_user.create_cart : Cart.new
      cart.save
      session[:cart_id] = cart.id
      cart
    end
  end

  def set_right_wrapper
    @right_wrapper = nil
  end

  protected
end
