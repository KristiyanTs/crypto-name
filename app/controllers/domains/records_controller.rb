class Domains::RecordsController < ApplicationController
  before_action :login

  def create
    @domain = Domain.find(params[:domain_id])
    record = @domain.records.create!(record_params)
    Domain::Record.new(record).call
  end

  def destroy
    @domain = Domain.find(params[:domain_id])

  end

  private 

  def record_params
    params.require(:record).permit(:type, :name, :value, :ttl, :priority, :service, :protocol, :port, :weight)
  end
end
