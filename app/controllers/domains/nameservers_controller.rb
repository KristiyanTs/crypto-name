class Domains::NameserversController < ApplicaitonController
  before_action :login

  def update
    domain = current_user.domains.find(params[:domain_id])
    domain.update!(domain_params)
    Domain::UpdateNameserversJob.perform_later(domain)

    redirect_to domains_path, notice: "We've begun handling your nameservers."
  end

  private

  def domain_params
    params.require(:domain).permit(nameservers_attributes: [:id, :name, :ip_addresses])
  end
end
