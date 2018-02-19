# frozen_string_literal: true

class Domain::UpdateNameserversJob < ApplicationJob
  def perform(domain, nameservers)
    Domain::Nameservers.new(domain, nameservers).call
  end
end
