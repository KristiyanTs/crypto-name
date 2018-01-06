class Domains::UnlockController < ApplicationController
  before_action :login

  def update
    @domain = Domain.find(params[:domain_id])
    Domain::Unlocker.new(@domain).call

    redirect_to domains_path, notice: e.message
  rescue => e
    redirect_to domains_path, notice: e.message
  end
end
