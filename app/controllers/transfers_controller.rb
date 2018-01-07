class TransfersController < ApplicationController
  before_action :login
  before_action :require_params

  def create
    Domain::Transfer.new(current_user, name, unlock_code).call # Maybe in background
    redirect domains_path
  end

  private

  def name
    params[:name]
  end

  def unlock_code
    params[:unlock_code]
  end

  def require_params
    redirect_to domains_path unless params[:name].present?
    redirect_to domains_path unless params[:unlock_code].present?
  end
end
