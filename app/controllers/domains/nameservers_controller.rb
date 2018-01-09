class Domains::NameserversController < ApplicaitonController
  before_action :nameservers
  before_action :login

  def update
    domain = current_user.domains.find(params[:domain_id])
    Domain::UpdateNameserversJob.perform_later(domain, params[:nameservers])

    redirect_to domains_path
  end

  private

  def nameservers
    redirect_to domains_path, notice: 'No Name Servers given' unless params[:nameservers]
  end
end
