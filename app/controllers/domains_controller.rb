class DomainsController < ApplicationController
  before_action :login

  def index
    @domains = current_user.domains
  end

  def new
    @detail = current_user.detail || Detail.new
    @domain = Domain.new(name: params[:domain_name])
    @price = @domain.pricing!
  end

  def show
    @domain = current_user.domains.find(params[:id])
  end

  def create
    current_user.domains.create!(domain_params)
    redirect_to domains_path, notice: 'Domain bought!'
  end

  def update
    @domain = current_user.domains.find(params[:id])
    @domain.assign_attributes(domain_params)

    respond_to do |format|
      if @domain.save
        format.js { flash[:suceess] = "Successfully updated." }
      else
        format.html { render :show }
        format.json { render json: @domain.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def domain_params
    params.require(:domain).permit(:name, :renewal)
  end
end
