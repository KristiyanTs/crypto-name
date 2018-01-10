class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action { flash.clear }

  # TODO: action helper
  def login
    redirect_to new_user_session_path unless current_user.present?
  end

  protected
end
