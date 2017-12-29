class AgreementsController < ApplicationController
  def index
    @private = GoDaddy.get_domain_agreements(tld, true)
    @public = GoDaddy.get_domain_agreements(tld, false)
  end

  private

  def tld
    params[:tld]
  end
end
