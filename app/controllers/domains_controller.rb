class DomainsController < ApplicationController
  before_action :login

  def index
    @domains = current_user.domains
  end

  def show
    @domain = current_user.domains.find(params[:id])
  end

  def create
    current_user.domains.create!(domain_params)
    redirect_to domains_path, notice: 'Domain bought!'
  end

  private

  def domain_params
    params.require(:domain).permit(:name)
  end

  #TODO extract:
  def login
    redirect_to new_user_session_path unless current_user.present?
  end
end