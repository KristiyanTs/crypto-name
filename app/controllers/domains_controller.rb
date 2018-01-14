class DomainsController < ApplicationController
  before_action :login

  def index
    @right_wrapper = 'domains/index_nav'
    @domains = current_user.domains
  end

  def show
    @right_wrapper = 'domains/show_nav'
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
