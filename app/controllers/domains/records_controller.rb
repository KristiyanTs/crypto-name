class Domains::RecordsController < ApplicationController
  before_action :login

  def create
    @domain = Domain.find(params[:domain_id])
    @record = @domain.records.create!(record_params)
    Domain::RecordCreator.new(@domain).call if @domain.records.where(kind: 'NS').count >= 2
    flash[:notice] = "Record added."
  end

  def update
    flash[:notice] = "Record updated."
    @domain = Domain.find(params[:domain_id])
    @record = Record.find(params[:id])
    @record.update!(record_params)
    Domain::RecordCreator.new(@domain).call if @domain.records.where(kind: 'NS').count >= 2
  end

  def destroy
    @record = Record.find(params[:id])
    @record_id = @record.id
    @record.destroy!
    flash[:notice] = "Record destroyed."
    # TODO: What happens when we destroy all records?
  end

  private 

  def record_params
    params.require(:record).permit(:kind, :name, :value, :ttl, :priority, :service, :protocol, :port, :weight)
  end
end
