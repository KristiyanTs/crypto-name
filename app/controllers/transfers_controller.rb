# frozen_string_literal: true

class TransfersController < ApplicationController
  before_action :login
  before_action :require_params

  def create
    Domain::Transfer.new(current_user, name, unlock_code, privacy).call # Maybe in background
    redirect domains_path
  end

  private

  def name
    params[:name]
  end

  def unlock_code
    params[:unlock_code]
  end

  def privacy
    !!params[:privacy] # TODO: front end should ask for this
  end

  def require_params
    redirect_to domains_path unless params[:name].present?
    redirect_to domains_path unless params[:unlock_code].present?
  end
end
