class AgreementsController < ApplicationController
  def index
    @private = GoDaddy.get_domain_agreements(tld, true).body.first.first[1]
    @public = GoDaddy.get_domain_agreements(tld, false).body.first.first[1]

  end

  private

  def tld
    params[:tld]
  end
end
